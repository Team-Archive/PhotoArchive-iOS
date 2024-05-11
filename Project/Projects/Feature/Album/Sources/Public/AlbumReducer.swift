//
//  AlbumReducer.swift
//  Album
//
//  Created by hanwe on 5/1/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import ComposableArchitecture
import Foundation
import ArchiveFoundation
import Domain
import Combine
import Photos

public struct AlbumReducer: Reducer {
  
  // MARK: - TCA Define
  
  public enum Action: Equatable {
    case setIsLoading(Bool)
    case setError(ArchiveError)
    case readAlbumList
    case setAlbumList([Album])
    case checkAlbumPermission
    case setAlbumPermission(PHAuthorizationStatus)
  }
  
  public struct State: Equatable {
    var isLoading: Bool = false
    var err: ArchiveError?
    var albumList: [Album] = []
    var albumPermission: PHAuthorizationStatus?
  }
  
  // MARK: - Private Property
  
  private let albumUsecase: AlbumUsecase
  
  private enum CancelId {
    case search
  }
  
  // MARK: - Public Property
  
  // MARK: - LifeCycle
  
  public init(albumUsecase: AlbumUsecase) {
    self.albumUsecase = albumUsecase
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
      case .readAlbumList:
        return .concatenate(
          .run(operation: { send in
            let albumList = self.fetchAlbumList()
            await send(.setAlbumList(albumList))
          })
        )
      case .setAlbumList(let albumList):
        state.albumList = albumList
        return .none
      case .checkAlbumPermission:
        return .concatenate(
          .run(operation: { send in
            let albumPermission = await self.checkAlbumPermission()
            switch albumPermission {
            case .authorized, .limited:
              await send(.readAlbumList)
            default:
              break
            }
            await send(.setAlbumPermission(albumPermission))
          })
        )
      case .setAlbumPermission(let status):
        state.albumPermission = status
        return .none
      }
    }
  }
  
  // MARK: - Private Method
  
  private func fetchAlbumList() -> [Album] {
    return self.albumUsecase.fetchAlbumList()
  }
  
  private func checkAlbumPermission() async -> PHAuthorizationStatus {
    return await self.albumUsecase.checkAlbumPermission()
  }
  
  // MARK: - Public Method
  
}


