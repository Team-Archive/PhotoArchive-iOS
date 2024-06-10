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
import UIComponents
import Combine

public struct AlbumView: View {
  
  // MARK: - Private Property
  
  private let store: StoreOf<AlbumReducer>
  @State private var stackPath: NavigationPath = .init()
  @State private var isShowAlbumSelect: Bool = false
  private var closeAction: () -> Void
  private var completeAction: ([PHAsset]) -> Void
  
  // MARK: - Internal Property
  
  // MARK: - Life Cycle
  
  public init(
    reducer: AlbumReducer,
    complete: @escaping ([PHAsset]) -> Void,
    close: @escaping () -> Void
  ) {
    self.store = .init(initialState: reducer.initialState, reducer: {
      return reducer
    })
    self.completeAction = complete
    self.closeAction = close
    self.store.send(.readAlbumList)
  }
  
  public var body: some View {
    
    WithViewStore(store, observe: { $0 }) { viewStore in
      NavigationStack(path: $stackPath) {
        ZStack {
          ATBackgroundView()
            .edgesIgnoringSafeArea(.all)
          if let permission = viewStore.albumPermission {
            switch permission {
            case .authorized, .limited:
              if let _ = viewStore.selectedAlbum {
                photoSelectorView()
              } else {
                Text("Unexpected Error.. :(\nNot Exist Album")
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
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
          viewStore.send(.checkAlbumPermission)
        })
        .fullScreenCover(isPresented: $isShowAlbumSelect) {
          AlbumListView(
            albumList: viewStore.albumList,
            isPresented: self.$isShowAlbumSelect
          ) { album in
            self.isShowAlbumSelect = false
            viewStore.send(.setSelectedAlbum(album))
          }
        }
      }
    }
    
  }
  
  // MARK: - Private Method
  
  @ViewBuilder
  private func photoSelectorView() -> some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      PhotoSelectorFactory.makePhotoSelector(
        store: store,
        type: viewStore.albumType,
        isShowAlbumSelector: self.$isShowAlbumSelect,
        complete: self.completeAction,
        close: self.closeAction
      )
    }
  }
  
  // MARK: - Internal Method
  
}
