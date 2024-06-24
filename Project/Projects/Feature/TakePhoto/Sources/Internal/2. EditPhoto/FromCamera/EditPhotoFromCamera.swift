//
//  EditPhotoFromCamera.swift
//  TakePhoto
//
//  Created by Aaron Hanwe LEE on 5/20/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import UIComponents
import ArchiveFoundation
import ComposableArchitecture
import AVFoundation

struct EditPhotoFromCamera: View {
  
  // MARK: - internal state
  
  // MARK: - private properties
  
  private let contentsViewCornerRadius: CGFloat = 24
  private let store: StoreOf<TakePhotoReducer>
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      GeometryReader { geometry in
        VStack(spacing: 48) {
          if let photoData = viewStore.selectedPhotoFromCamera {
            EditPhotoView(photoData: photoData)
              .frame(
                width: geometry.size.width - (.designContentsInset * 2),
                height: geometry.size.width - (.designContentsInset * 2)
              )
              .clipped()
              .clipShape(.rect(cornerRadius: self.contentsViewCornerRadius))
              .padding(.designContentsSideInsets)
          } else {
            Text("Photo data not found :(")
              .frame(
                width: geometry.size.width - (.designContentsInset * 2),
                height: geometry.size.width - (.designContentsInset * 2)
              )
          }
          EditPhotoToolbarView(
            store: self.store,
            editCompleteAction: {
              viewStore.send(.setIsCompleteEditPhoto(true))
            },
            editCancelAction: {
              viewStore.send(.clearSelectedPhoto)
            }
          )
        }
      }
    }
  }
  
  init(
    store: StoreOf<TakePhotoReducer>
  ) {
    self.store = store
  }
  
  // MARK: - private method
  
  @ViewBuilder
  private func EditPhotoView(photoData: Data) -> some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      GeometryReader { geometry in
        ZStack {
          ATDataImage(data: photoData)
            .resizable()
            .scaledToFill()
            .aspectRatio(contentMode: .fill)
            .clipped()
          VStack() {
            Spacer()
            ATInputView(
              placeholder: L10n.Localizable.takePhotoEditTextInputPlaceholder, 
              message: viewStore.binding(get: \.candidateContentsFromCamera, send: TakePhotoReducer.Action.setCandidateContentsFromCamera),
              Int(viewStore.maxTextInputCount)
            )
            .padding(.bottom, 20)
          }
        }
      }
    }
  }
  
  // MARK: - internal method
  
}
