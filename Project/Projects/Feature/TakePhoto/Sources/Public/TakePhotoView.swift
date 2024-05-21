//
//  TakePhotoView.swift
//  TakePhoto
//
//  Created by hanwe on 5/19/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import Photos
import ArchiveFoundation
import UIComponents
import AppRoute

public struct TakePhotoView<PhotoPickerView>: View where PhotoPickerView: PhotoPicker {
  
  // MARK: - Private Property
  
  private let store: StoreOf<TakePhotoReducer>
  @State private var isShowPhotoPickerView: Bool = false
  
  // MARK: - Internal Property
  
  // MARK: - Life Cycle
  
  public init(
    reducer: TakePhotoReducer
  ) {
    self.store = .init(initialState: reducer.initialState, reducer: {
      return reducer
    })
  }
  
  public var body: some View {
    
    WithViewStore(store, observe: { $0 }) { viewStore in
      ZStack {
        ATBackgroundView()
          .edgesIgnoringSafeArea(.all)
        if let selectedPhoto = viewStore.selectedPhoto {
          switch selectedPhoto {
          case .fromCamera:
            EditPhotoFromCamera(store: self.store)
          case .fromAlbum:
            EditPhotoFromAlbum(store: self.store)
          }
        } else {
          TakePhotoBaseFrameView(
            store: self.store,
            contentsView: cameraContentsView(),
            selectPhotoFromAlbumAction: {
              isShowPhotoPickerView = true
            }
          )
          .onAppear {
            viewStore.send(.checkCameraPermission)
          }
          .fullScreenCover(isPresented: $isShowPhotoPickerView) {
            PhotoPickerView { assetList in
              isShowPhotoPickerView = false
              viewStore.send(.setSelectedPhoto(.fromAlbum(assetList)))
            } closeAction: {
              isShowPhotoPickerView = false
            }
          }
        }
      }
    }
    
  }
  
  // MARK: - Private Method
  
  @ViewBuilder
  private func cameraContentsView() -> some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      if let permission = viewStore.cameraPermission {
        switch permission {
        case .authorized:
          TakePhotoCameraView(session: viewStore.cameraSession)
        default:
          TakePhotoNotPermittedView {
            ArchiveCommonUtil.openSetting()
          }
        }
      } else {
        TakePhotoNotPermittedView {
          ArchiveCommonUtil.openSetting()
        }
      }
    }
  }
  
  // MARK: - Internal Method
  
}
