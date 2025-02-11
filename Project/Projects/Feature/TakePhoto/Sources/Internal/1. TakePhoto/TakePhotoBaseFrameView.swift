//
//  TakePhotoBaseFrameView.swift
//  TakePhoto
//
//  Created by hanwe on 5/19/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import UIComponents
import ArchiveFoundation
import ComposableArchitecture
import AVFoundation

struct TakePhotoBaseFrameView<Content>: View where Content: View {
  
  // MARK: - internal state
  
  // MARK: - private properties
  
  private let contentsView: Content
  private let contentsViewCornerRadius: CGFloat = 24
  private let store: StoreOf<TakePhotoReducer>
  private let selectPhotoFromAlbumAction: () -> Void
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      GeometryReader { geometry in
        VStack(spacing: 48) {
          contentsView
            .frame(
              width: geometry.size.width == 0 ? 10 : geometry.size.width - (.designContentsInset * 2),
              height: geometry.size.width == 0 ? 10 : geometry.size.width - (.designContentsInset * 2)
            )
            .clipped()
            .clipShape(.rect(cornerRadius: self.contentsViewCornerRadius))
            .padding(.designContentsSideInsets)
          TakePhotoToolbarView(
            selectPhotoFromAlbumAction: {
              selectPhotoFromAlbumAction()
            }, takePhotoAction: {
              viewStore.send(.takePhoto)
            }, switchCameraAction: {
              viewStore.send(.switchCamera)
            }
          )
        }
      }
    }
  }
  
  init(
    store: StoreOf<TakePhotoReducer>,
    contentsView: Content,
    selectPhotoFromAlbumAction: @escaping () -> Void
  ) {
    self.store = store
    self.contentsView = contentsView
    self.selectPhotoFromAlbumAction = selectPhotoFromAlbumAction
  }
  
  // MARK: - private method
  
  @ViewBuilder
  private func TakePhotoToolbarView(
    selectPhotoFromAlbumAction: @escaping () -> Void,
    takePhotoAction: @escaping () -> Void,
    switchCameraAction: @escaping () -> Void
  ) -> some View {
    
    let additionalActionButtonSize: CGSize = .init(width: 44, height: 44)
    
    WithViewStore(store, observe: { $0 }) { viewStore in
      HStack(spacing: 52) {
        Button(action: {
          selectPhotoFromAlbumAction()
        }, label: {
          Gen.Images.gallery.image
        })
        .frame(
          width: additionalActionButtonSize.width,
          height: additionalActionButtonSize.height
        )
        
        TakePhotoButtonView {
          takePhotoAction()
        }
        
        Button(action: {
          switchCameraAction()
        }, label: {
          Gen.Images.flip.image.renderingMode(.template)
            .foregroundStyle(viewStore.cameraPermission == .authorized ? Gen.Colors.white.color : Gen.Colors.gray300.color)
        })
        .frame(
          width: additionalActionButtonSize.width,
          height: additionalActionButtonSize.height
        )
        .disabled(!(viewStore.cameraPermission == .authorized))
      }
    }
  }
  
  @ViewBuilder
  private func TakePhotoButtonView(
    takePhotoAction: @escaping () -> Void
  ) -> some View {
    
    let takePhotoButtonSize: CGSize = .init(width: 72, height: 72)
    let takePhotoInnerButtonSize: CGSize = .init(width: 60, height: 60)
    let enableStartColor: Color = Gen.Colors.gradationMainStart.color
    let enableEndColor: Color = Gen.Colors.gradationMainEnd.color
    let disableColor: Color = Gen.Colors.gray300.color
    
    WithViewStore(store, observe: { $0 }) { viewStore in
      Button(action: {
        takePhotoAction()
      }, label: {
        ZStack {
          Circle()
            .fill(.clear)
            .stroke(
              LinearGradient(
                gradient: Gradient(
                  colors: [
                    viewStore.cameraPermission == .authorized ? enableStartColor : disableColor,
                    viewStore.cameraPermission == .authorized ? enableEndColor : disableColor
                  ]),
                startPoint: .top,
                endPoint: .bottom
              ),
              lineWidth: 3
            )
            .frame(
              width: takePhotoButtonSize.width,
              height: takePhotoButtonSize.height
            )
          Circle()
            .fill(viewStore.cameraPermission == .authorized ? Gen.Colors.white.color : disableColor)
            .frame(
              width: takePhotoInnerButtonSize.width,
              height: takePhotoInnerButtonSize.height
            )
        }
      })
      .disabled(!(viewStore.cameraPermission == .authorized))
    }
  }
  
  // MARK: - internal method
  
}

//#Preview {
//  VStack {
//    TakePhotoBaseFrameView(contentsView: Text("hi"), store: TakePhotoReducer(cameraUsecase: <#T##any CameraUsecase#>))
//  }
//}
