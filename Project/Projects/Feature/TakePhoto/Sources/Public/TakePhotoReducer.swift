//
//  TakePhotoReducer.swift
//  Camera
//
//  Created by hanwe on 5/19/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import ComposableArchitecture
import Foundation
import ArchiveFoundation
import Domain
import Combine
import AVFoundation
import Photos
import AppRoute

public struct TakePhotoReducer: Reducer {
  
  public enum SelectedPhoto: Equatable {
    case fromCamera(Data)
    case fromAlbum([PHAsset])
  }
  
  public enum PostContents: Equatable {
    case fromCamera(photoData: Data, comment: String)
    case fromAlbum(assetList: [PHAsset], comment: [PHAsset: String])
  }
  
  public enum TakePhotoState: Equatable {
    case photo
    case posting
    case complete
  }
  
  // MARK: - TCA Define
  
  public enum Action: Equatable {
    case setIsLoading(Bool)
    case setError(ArchiveError)
    case checkCameraPermission
    case setAlbumPermission(AVAuthorizationStatus)
    case takePhoto
    case switchCamera
    case setSelectedPhoto(SelectedPhoto)
    case clearSelectedPhoto
    case setCurrentPhotoFromAlbumIndex(UInt?)
    case setCandidateContentsFromCamera(String)
    case setCandidateContentsFromAlbum(asset: PHAsset, contents: String)
    case setIsCompleteEditPhoto(Bool)
    case setSelectedSendDestination([UserInformation]?)
    case post(contents: PostContents, destination: [UserInformation])
    case setTakePhotoState(TakePhotoState)
  }
  
  public struct State: Equatable {
    var isLoading: Bool = false
    var err: ArchiveError?
    let cameraSession: AVCaptureSession
    let maxTextInputCount: UInt
    let friendsList: [UserInformation]
    var cameraPermission: AVAuthorizationStatus?
    var selectedPhoto: SelectedPhoto?
    var selectedPhotoFromCamera: Data?
    var selectedPhotoFromAlbum: [PHAsset]?
    var currentPhotoFromAlbumIndex: UInt?
    var candidateContentsFromCamera: String = ""
    var candidateContentsFromAlbum: [PHAsset: String] = [:]
    var isValidContents: Bool = true
    var isCompleteEditPhoto: Bool = false
    var selectedSendDestination: [UserInformation]?
    var takePhotoState: TakePhotoState = .photo
    
    public init(
      cameraSession: AVCaptureSession,
      maxTextInputCount: UInt,
      friendsList: [UserInformation]
    ) {
      self.cameraSession = cameraSession
      self.maxTextInputCount = maxTextInputCount
      self.friendsList = friendsList
    }
  }
  
  // MARK: - Private Property
  
  private enum CancelId {
    case search
  }
  
  private let cameraUsecase: CameraUsecase
  private let postingUsecase: PostingUsecase
  private let myInfo: MyInformation
  
  // MARK: - Public Property
  
  public var initialState: State
  
  // MARK: - LifeCycle
  
  public init(
    myInfo: MyInformation,
    cameraUsecase: CameraUsecase,
    postingUsecase: PostingUsecase,
    maxTextInputCount: UInt
  ) {
    self.myInfo = myInfo
    self.cameraUsecase = cameraUsecase
    self.postingUsecase = postingUsecase
    self.initialState = State(
      cameraSession: cameraUsecase.session,
      maxTextInputCount: maxTextInputCount,
      friendsList: myInfo.friendsList
    )
  }
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .setIsLoading(let isLoading):
        state.isLoading = isLoading
        return .none
      case .setError(let err):
        state.err = err
        return .none
      case .checkCameraPermission:
        return .concatenate(
          .run(operation: { send in
            let albumPermission = await self.checkCameraPermission()
            switch albumPermission {
            case .authorized:
              self.cameraUsecase.startSession()
            default:
              break
            }
            await send(.setAlbumPermission(albumPermission))
          })
        )
      case .setAlbumPermission(let status):
        state.cameraPermission = status
        return .none
      case .takePhoto:
        return .concatenate(
          .run(operation: { send in
            if let capturedPhotoData = await self.takePhoto() {
              await send(.setSelectedPhoto(.fromCamera(capturedPhotoData)))
            } else {
              await send(.setError(.init(.cameraCaptureFail)))
            }
          })
        )
      case .switchCamera:
        self.switchCamera()
        return .none
      case .setSelectedPhoto(let selectedPhoto):
        switch selectedPhoto {
        case .fromAlbum(let assets):
          state.selectedPhotoFromAlbum = assets
          for asset in assets {
            state.candidateContentsFromAlbum[asset] = ""
          }
        case .fromCamera(let capturedPhotoData):
          state.selectedPhotoFromCamera = capturedPhotoData
        }
        state.selectedPhoto = selectedPhoto
        return .none
      case .clearSelectedPhoto:
        state.selectedPhoto = nil
        state.selectedPhotoFromAlbum = nil
        state.selectedPhotoFromCamera = nil
        state.currentPhotoFromAlbumIndex = nil
        state.candidateContentsFromCamera = ""
        state.candidateContentsFromAlbum = [:]
        state.isValidContents = true
        return .none
      case .setCurrentPhotoFromAlbumIndex(let index):
        state.currentPhotoFromAlbumIndex = index
        return .none
      case .setCandidateContentsFromCamera(let contents):
        state.isValidContents = self.isValidContents(contents: contents)
        state.candidateContentsFromCamera = contents
        return .none
      case .setCandidateContentsFromAlbum(let asset, let contents):
        state.isValidContents = self.isValidContents(contents: contents) && self.isAllValidContents(contents: state.candidateContentsFromAlbum)
        state.candidateContentsFromAlbum[asset] = contents
        return .none
      case .setIsCompleteEditPhoto(let isComplete):
        state.isCompleteEditPhoto = isComplete
        state.selectedSendDestination = nil
        return .none
      case .setSelectedSendDestination(let list):
        state.selectedSendDestination = list
        return .none
      case .setTakePhotoState(let stateValue):
        state.takePhotoState = stateValue
        return .none
      case .post(let contents, let destination):
        state.takePhotoState = .posting
        return .run { send in
          let itemListResult = await self.convertPostContentsToPostingItem(contents)
          switch itemListResult {
          case .success(let itemList):
            let postResult = await self.post(itemList: itemList, toUserIdList: destination.map { $0.id })
            switch postResult {
            case .success(_):
              await send(.setTakePhotoState(.complete))
            case .failure(let err):
              await send(.setError(err))
            }
          case .failure(let err):
            await send(.setError(err))
          }
        }
      }
    }
  }
  
  // MARK: - Private Method
  
  private func checkCameraPermission() async -> AVAuthorizationStatus {
    return await self.cameraUsecase.checkCameraAuthorization()
  }
  
  private func takePhoto() async -> Data? {
    return await self.cameraUsecase.takePhoto()
  }
  
  private func switchCamera() {
    self.cameraUsecase.switchCamera()
  }
  
  private func isAllValidContents(contents: [PHAsset: String]) -> Bool {
    let allKeys = Array(contents.keys)
    for key in allKeys {
      if let value = contents[key] {
        if !isValidContents(contents: value) {
          return false
        }
      }
    }
    return true
  }
  
  private func isValidContents(contents: String) -> Bool {
    self.postingUsecase.isValidContents(contents: contents)
  }
  
  private func convertPostContentsToPostingItem(_ contents: PostContents) async -> Result<[PostingItem], ArchiveError> {
    switch contents {
    case .fromCamera(let photoData, let comment):
      return .success([.init(
        imageData: photoData,
        comment: comment == "" ? nil : comment
      )])
    case .fromAlbum(let assetList, let comment):
      let photoDataListResult = await self.postingUsecase.assetListToImageDataList(assetList: assetList)
      switch photoDataListResult {
      case .success(let dataList):
        var returnValue: [PostingItem] = []
        for i in 0..<assetList.count {
          guard let asset = assetList[safe: i] else { continue }
          guard let photoData = dataList[safe: i] else { continue }
          returnValue.append(.init(imageData: photoData, comment: comment[asset]))
        }
        return .success(returnValue)
      case .failure(let err):
        return .failure(err)
      }
    }
  }
  
  private func post(itemList: [PostingItem], toUserIdList: [String]) async -> Result<Void, ArchiveError> {
    return await self.postingUsecase.post(
      accessToken: self.myInfo.accessToken,
      itemList: itemList,
      toUserIdList: toUserIdList
    )
  }
  
  // MARK: - Public Method
  
}

