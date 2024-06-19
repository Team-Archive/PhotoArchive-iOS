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
  
  public enum AlbumType: Equatable {
    case single(navigationTitle: String, completeButtonTitle: String)
    case multi(maxSelectableCount: UInt)
  }
  
  // MARK: - TCA Define
  
  public enum Action: Equatable {
    case setIsLoading(Bool)
    case setError(ArchiveError)
    case readAlbumList
    case setAlbumList([Album])
    case checkAlbumPermission
    case setAlbumPermission(PHAuthorizationStatus)
    case setAlbumAssetList([PHAsset])
    case setSelectedAlbum(Album)
    case appendSelectedAsset(PHAsset)
    case removeSelectedAsset(PHAsset)
  }
  
  public struct State: Equatable {
    let albumType: AlbumType
    var isLoading: Bool = false
    var err: ArchiveError?
    var albumList: [Album] = []
    var albumPermission: PHAuthorizationStatus?
    var selectedAlbum: Album?
    var albumAssetList: [PHAsset] = []
    var selectedAssetList: [PHAsset] = []
  }
  
  // MARK: - Private Property
  
  private let albumUsecase: AlbumUsecase
  
  // MARK: - Public Property
  
  public var initialState: State
  
  // MARK: - LifeCycle
  
  public init(
    albumType: AlbumType,
    albumUsecase: AlbumUsecase
  ) {
    self.albumUsecase = albumUsecase
    self.initialState = State(albumType: albumType)
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
            if let album = albumList.first {
              await send(.setSelectedAlbum(album))
            }
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
      case .setSelectedAlbum(let album):
        state.selectedAlbum = album
        return .concatenate(
          .run(operation: { send in
            let assetList: [PHAsset] = {
              var returnValue: [PHAsset] = []
              for i in 0..<album.fetchResult.count {
                if let asset: PHAsset = album.fetchResult.object(at: i) as? PHAsset {
                  returnValue.append(asset)
                }
              }
              return returnValue
            }()
            await send(.setAlbumAssetList(assetList))
          })
        )
      case .appendSelectedAsset(let asset):
        state.selectedAssetList.append(asset)
        return .none
      case .removeSelectedAsset(let asset):
        state.selectedAssetList = state.selectedAssetList.filter { $0 != asset }
        return .none
      case .setAlbumAssetList(let list):
        state.albumAssetList = list
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

