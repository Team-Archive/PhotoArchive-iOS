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
          Color.brown
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
          EditPhotoToolbarView(
            store: self.store,
            editCompleteAction: {
              print("편집완료")
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
  
  // MARK: - internal method
  
}
