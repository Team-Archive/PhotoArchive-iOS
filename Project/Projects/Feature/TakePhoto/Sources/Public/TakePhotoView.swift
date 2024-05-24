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
        switch viewStore.takePhotoState {
        case .photo:
          photoStateView()
        case .posting:
          Text("hi")
            .foregroundStyle(.white)
        case .complete:
          Text("hola")
            .foregroundStyle(.white)
        }

      }
    }
    
  }
  
  // MARK: - Private Method
  
  @ViewBuilder
  private func photoStateView() -> some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      if let selectedPhoto = viewStore.selectedPhoto {
        VStack {
          switch selectedPhoto {
          case .fromCamera:
            EditPhotoFromCamera(store: self.store)
          case .fromAlbum:
            EditPhotoFromAlbum(store: self.store)
          }
        }
//          .fullScreenCover(isPresented: viewStore.binding(get: { $0.takePhotoState == .posting }, send: { _ in TakePhotoReducer.Action.setError(.init(.commonError)) })) {
//            Text("hi")
//          }
        .sheet(isPresented: viewStore.binding(
          get: { $0.isCompleteEditPhoto && $0.takePhotoState == .photo },
          send: { _ in TakePhotoReducer.Action.setIsCompleteEditPhoto(false) })
        ) {
          SendDestinationPickerView(
            candidateList: viewStore.friendsList,
            action: { selectedList in
              viewStore.send(.setSelectedSendDestination(Array(selectedList)))
              guard let postContents: TakePhotoReducer.PostContents = {
                guard let selectedPhoto = viewStore.selectedPhoto else { return nil }
                switch selectedPhoto {
                case .fromCamera(let data):
                  return .fromCamera(photoData: data, comment: viewStore.candidateContentsFromCamera)
                case .fromAlbum(let assets):
                  return .fromAlbum(assetList: assets, comment: viewStore.candidateContentsFromAlbum)
                }
              }() else { return }
              guard let destination = viewStore.selectedSendDestination else { return }
              viewStore.send(.post(contents: postContents, destination: destination))
            }
          )
          .presentationDetents([.fraction(0.35), .medium, .large])
          .presentationDragIndicator(.visible)
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
