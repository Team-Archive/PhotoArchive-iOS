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

public struct TakePhotoReducer: Reducer {
  
  // MARK: - TCA Define
  
  public enum Action: Equatable {
    case setIsLoading(Bool)
    case setError(ArchiveError)
    case checkCameraPermission
    case setAlbumPermission(AVAuthorizationStatus)
  }
  
  public struct State: Equatable {
    var isLoading: Bool = false
    var err: ArchiveError?
    var cameraPermission: AVAuthorizationStatus?
  }
  
  // MARK: - Private Property
  
  private enum CancelId {
    case search
  }
  
  private let cameraUsecase: CameraUsecase
  
  // MARK: - Public Property
  
  // MARK: - LifeCycle
  
  public init(
    cameraUsecase: CameraUsecase
  ) {
    self.cameraUsecase = cameraUsecase
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
              // TODO: 카메라를 켜야할듯? 봐서...
              break
            default:
              break
            }
            await send(.setAlbumPermission(albumPermission))
          })
        )
      case .setAlbumPermission(let status):
        state.cameraPermission = status
        return .none
      }
    }
  }
  
  // MARK: - Private Method
  
  private func checkCameraPermission() async -> AVAuthorizationStatus {
    return await self.cameraUsecase.checkCameraAuthorization()
  }
  
  // MARK: - Public Method
  
}

