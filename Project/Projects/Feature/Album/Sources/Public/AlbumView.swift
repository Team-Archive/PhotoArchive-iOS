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

public struct AlbumView: View {
  
  // MARK: - Private Property
  
  private let store: StoreOf<AlbumReducer>
  @State private var stackPath: NavigationPath = .init()
  var closeAction: () -> Void
  var completeAction: ([Image]) -> Void
  
  // MARK: - Internal Property
  
  // MARK: - Life Cycle
  
  public init(
    reducer: AlbumReducer,
    complete: @escaping ([Image]) -> Void,
    close: @escaping () -> Void
  ) {
    self.store = .init(initialState: .init(), reducer: {
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
          if let permission = viewStore.albumPermission {
            switch permission {
            case .authorized, .limited:
              if let album = viewStore.selectedAlbum {
                AlbumMultiSelectPhotoView(
                  store: store,
                  album: album) {
                    print("done")
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
          if let permission = viewStore.albumPermission {
            switch permission {
            case .authorized, .limited:
              ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                  closeAction()
                }) {
                  Gen.Images.close.image
                    .renderingMode(.template)
                    .foregroundStyle(Gen.Colors.white.color)
                }
              }
              
              ToolbarItem(placement: .navigationBarTrailing) {
                CompleteButtonView {
                  print("업로드 하자")
                }
              }
              
              ToolbarItem(placement: .principal) {
                ReplaceAlbumButtonView(action: {
                  print("Select album")
                })
              }
            default:
              ToolbarItem(content: {})
            }
          } else {
            ToolbarItem(content: {})
          }
        }
        .onAppear(perform: {
          viewStore.send(.checkAlbumPermission)
        })
      }
    }
    
  }
  
  // MARK: - Private Method
  
  @ViewBuilder
  private func CompleteButtonView(action: @escaping () -> Void) -> some View {
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
