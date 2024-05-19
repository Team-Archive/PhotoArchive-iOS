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

struct TakePhotoBaseFrameView<Content>: View where Content: View {
  
  // MARK: - internal state
  
  // MARK: - private properties
  
  private let contentsView: Content
  private let contentsViewCornerRadius: CGFloat = 24
  private let store: StoreOf<TakePhotoReducer>
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  var body: some View {
    GeometryReader { geometry in
      VStack(spacing: 48) {
        contentsView
          .frame(
            width: geometry.size.width - (.designContentsInset * 2),
            height: geometry.size.width - (.designContentsInset * 2)
          )
          .clipped()
          .clipShape(.rect(cornerRadius: self.contentsViewCornerRadius))
          .padding(
            .init(
              top: 0,
              leading: .designContentsInset,
              bottom: 0,
              trailing: .designContentsInset
            )
          )
        TakePhotoToolbarView(
          selectPhotoFromAlbumAction: {
            print("앨범에서 사진 고르기")
          }, takePhotoAction: {
            print("사진 찍기")
          }, switchCameraAction: {
            print("카메라 돌리기")
          }
        )
//        EditPhotoToolbarView(
//          editCompleteAction: {
//            print("사진 편집 완료")
//          }, editCancelAction: {
//            print("사진 편집 취소")
//          }
//        )
      }
    }
  }
  
  init(
    contentsView: Content,
    store: StoreOf<TakePhotoReducer>
  ) {
    self.contentsView = contentsView
    self.store = store
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
          Gen.Images.flip.image
        })
        .frame(
          width: additionalActionButtonSize.width,
          height: additionalActionButtonSize.height
        )
      }
    }
  }
  
  @ViewBuilder
  private func TakePhotoButtonView(
    takePhotoAction: @escaping () -> Void
  ) -> some View {
    
    let takePhotoButtonSize: CGSize = .init(width: 72, height: 72)
    let takePhotoInnerButtonSize: CGSize = .init(width: 60, height: 60)
    
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
                  Gen.Colors.gradationMainStart.color,
                  Gen.Colors.gradationMainEnd.color
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
          .fill(Gen.Colors.white.color)
          .frame(
            width: takePhotoInnerButtonSize.width,
            height: takePhotoInnerButtonSize.height
          )
      }
    })
  }
  
  @ViewBuilder
  private func EditPhotoToolbarView(
    editCompleteAction: @escaping () -> Void,
    editCancelAction: @escaping () -> Void
  ) -> some View {
    HStack(spacing: 30) {
      Button(action: {
        editCancelAction()
      }, label: {
        Gen.Images.close.image.renderingMode(.template)
          .resizable()
          .frame(width: 22, height: 22)
          .foregroundStyle(Gen.Colors.white.color)
      })
      .frame(width: 44, height: 44)
      
      ATBottomActionButton(title: L10n.Localizable.takePhotoEditCompleteButtonTitle, action: {
        editCompleteAction()
      })
      .frame(width: 161)
      
      Color.clear
        .frame(width: 44, height: 44)
    }
  }
  
  // MARK: - internal method
  
}

//#Preview {
//  VStack {
//    TakePhotoBaseFrameView(contentsView: Text("hi"), store: TakePhotoReducer(cameraUsecase: <#T##any CameraUsecase#>))
//  }
//}
