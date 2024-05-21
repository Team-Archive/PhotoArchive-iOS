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
  }
  
  public struct State: Equatable {
    var isLoading: Bool = false
    var err: ArchiveError?
    var cameraPermission: AVAuthorizationStatus?
    var cameraSession: AVCaptureSession
    var selectedPhoto: SelectedPhoto?
    var selectedPhotoFromCamera: Data?
    var selectedPhotoFromAlbum: [PHAsset]?
    
    public init(cameraSession: AVCaptureSession) {
      self.cameraSession = cameraSession
    }
  }
  
  // MARK: - Private Property
  
  private enum CancelId {
    case search
  }
  
  private let cameraUsecase: CameraUsecase
  
  // MARK: - Public Property
  
  public var initialState: State
  
  // MARK: - LifeCycle
  
  public init(
    cameraUsecase: CameraUsecase
  ) {
    self.cameraUsecase = cameraUsecase
    self.initialState = State(cameraSession: cameraUsecase.session)
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
  
  // MARK: - Public Method
  
}

