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
  }
  
  public struct State: Equatable {
    var isLoading: Bool = false
    var err: ArchiveError?
    let cameraSession: AVCaptureSession
    let maxTextInputCount: UInt
    var cameraPermission: AVAuthorizationStatus?
    var selectedPhoto: SelectedPhoto?
    var selectedPhotoFromCamera: Data?
    var selectedPhotoFromAlbum: [PHAsset]?
    var currentPhotoFromAlbumIndex: UInt?
    var candidateContentsFromCamera: String = ""
    var isValidContents: Bool = true
    
    public init(
      cameraSession: AVCaptureSession,
      maxTextInputCount: UInt
    ) {
      self.cameraSession = cameraSession
      self.maxTextInputCount = maxTextInputCount
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
      maxTextInputCount: maxTextInputCount
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
        state.isValidContents = true
        return .none
      case .setCurrentPhotoFromAlbumIndex(let index):
        state.currentPhotoFromAlbumIndex = index
        return .none
      case .setCandidateContentsFromCamera(let contents):
        state.isValidContents = self.isValidContents(contents: contents)
        state.candidateContentsFromCamera = contents
        return .none
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
  
  private func isValidContents(contents: String) -> Bool {
    self.postingUsecase.isValidContents(contents: contents)
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

