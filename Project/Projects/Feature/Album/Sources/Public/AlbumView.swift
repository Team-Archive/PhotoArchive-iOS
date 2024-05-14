//
//  AlbumView.swift
//  Album
//
//  Created by hanwe on 5/1/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import Domain
import Photos
import ArchiveFoundation

public struct AlbumView: View {
  
  // MARK: - Private Property
  
  private let store: StoreOf<AlbumReducer>
  
  // MARK: - Internal Property
  
  // MARK: - Sub UI Component
  
  // MARK: - Body
  
  public var body: some View {
    
    WithViewStore(store, observe: { $0 }) { viewStore in
      ZStack {
        if let permission = viewStore.albumPermission {
          switch permission {
          case .authorized, .limited:
//            AlbumListView(albumList: viewStore.albumList, selected: { selected in
//              print("selected: \(selected)")
//            })
            if let album = viewStore.albumList[safe: 0] {
              AlbumPhotoView(album: viewStore.albumList[0]) { asset in
                print("asset: \(asset)")
              }
            }
          default:
            AlbumNotPermittedView {
              ArchiveCommonUtil.openSetting()
            }
          }
        } else {
          AlbumNotPermittedView {
            ArchiveCommonUtil.openSetting()
          }
        }
      }
      .onAppear(perform: {
        viewStore.send(.checkAlbumPermission)
      })
    }
  }
  
  // MARK: - Life Cycle
  
  public init(reducer: AlbumReducer) {
    self.store = .init(initialState: .init(), reducer: {
      return reducer
    })
    self.store.send(.readAlbumList)
  }
  
  // MARK: - Private Method
  
  // MARK: - Internal Method
  
}
