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
  var closeAction: () -> Void
  var completeAction: ([PHAsset]) -> Void
  
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
                switch viewStore.albumType {
                case .multi:
                  AlbumMultiSelectPhotoView(
                    store: store
                  )
                case .single:
                  AlbumSingleSelectPhotoView(
                    store: store
                  )
                }
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
        .toolbar {
          switch viewStore.albumType {
          case .multi:
            MultiSelectToolBar(viewStore: viewStore)
          case .single(let navigationTitle, let buttonTitle):
            SingleSelectToolBar(
              viewStore: viewStore,
              navigationTitle: navigationTitle,
              completeButtonTitle: buttonTitle
            )
          }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
          viewStore.send(.checkAlbumPermission)
        })
      }
    }
    
  }
  
  // MARK: - Private Method
  
  @ToolbarContentBuilder
  private func MultiSelectToolBar(viewStore: ViewStore<AlbumReducer.State, AlbumReducer.Action>) -> some ToolbarContent {
    if let permission = viewStore.albumPermission {
      switch permission {
      case .authorized, .limited:
        ToolbarItem(placement: .topBarLeading) {
          Button(action: {
            closeAction()
          }) {
            Gen.Images.close.image
              .renderingMode(.template)
              .foregroundStyle(Gen.Colors.white.color)
          }
        }
        
        ToolbarItem(placement: .topBarTrailing) {
          MultiSelectCompleteButtonView {
            self.completeAction(viewStore.selectedAssetList)
          }
        }
        
        ToolbarItem(placement: .principal) {
          ReplaceAlbumButtonView(action: {
            isShowAlbumSelect = true
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
      default:
        ToolbarItem(content: {})
      }
    } else {
      ToolbarItem(content: {})
    }
  }
  
  @ToolbarContentBuilder
  private func SingleSelectToolBar(
    viewStore: ViewStore<AlbumReducer.State, AlbumReducer.Action>,
    navigationTitle: String,
    completeButtonTitle: String
  ) -> some ToolbarContent {
    if let permission = viewStore.albumPermission {
      switch permission {
      case .authorized, .limited:
        ToolbarItem(placement: .topBarLeading) {
          Button(action: {
            closeAction()
          }) {
            Gen.Images.close.image
              .renderingMode(.template)
              .foregroundStyle(Gen.Colors.white.color)
          }
        }
        
        ToolbarItem(placement: .topBarTrailing) {
          WithViewStore(store, observe: { $0 }) { viewStore in
            Button(action: {
              self.completeAction(viewStore.selectedAssetList)
            }) {
              if viewStore.selectedAssetList.count > 0 {
                Text(completeButtonTitle)
                  .font(.fonts(.buttonSemiBold14))
                  .foregroundStyle(Gen.Colors.purple.color)
              } else {
                Text(completeButtonTitle)
                  .font(.fonts(.body14))
                  .foregroundStyle(Gen.Colors.gray600.color)
              }
            }
            .disabled(!(viewStore.selectedAssetList.count > 0))
          }
        }
        
        ToolbarItem(placement: .principal) {
          Text(navigationTitle)
            .font(.fonts(.body16))
            .foregroundColor(Gen.Colors.white.color)
        }
        
      default:
        ToolbarItem(content: {})
      }
    } else {
      ToolbarItem(content: {})
    }
  }
  
  @ViewBuilder
  private func MultiSelectCompleteButtonView(action: @escaping () -> Void) -> some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      Button(action: {
        action()
      }) {
        if viewStore.selectedAssetList.count > 0 {
          EnableCompleteButtonView(count: UInt(viewStore.selectedAssetList.count))
        } else {
          DisableCompleteButtonView()
        }
      }
      .disabled(!(viewStore.selectedAssetList.count > 0))
    }
  }
  
  @ViewBuilder
  private func EnableCompleteButtonView(count: UInt) -> some View {
    HStack(spacing: 4) {
      Text("\(count)")
        .font(.fonts(.buttonSemiBold14))
        .foregroundStyle(Gen.Colors.purple.color)
      Text(L10n.Localizable.albumPhotoSelectCompleteButtonTitle)
        .font(.fonts(.buttonSemiBold14))
        .foregroundStyle(Gen.Colors.white.color)
    }
  }
  
  
  @ViewBuilder
  private func DisableCompleteButtonView() -> some View {
    Text(L10n.Localizable.albumPhotoSelectCompleteButtonTitle)
      .font(.fonts(.body14))
      .foregroundStyle(Gen.Colors.gray600.color)
  }
  
  @ViewBuilder
  private func ReplaceAlbumButtonView(action: @escaping () -> Void) -> some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      Button(action: {
        action()
      }) {
        HStack(spacing: 3) {
          if let album = viewStore.selectedAlbum {
            Text(album.name)
              .font(.fonts(.body16))
              .foregroundStyle(Gen.Colors.white.color)
          }
          Gen.Images.arrow.image
            .resizable()
            .renderingMode(.template)
            .foregroundStyle(Gen.Colors.white.color)
            .scaledToFit()
            .rotationEffect(.degrees(90))
            .frame(width: 16, height: 16)
        }
      }
    }
  }
  
  // MARK: - Internal Method
  
}
