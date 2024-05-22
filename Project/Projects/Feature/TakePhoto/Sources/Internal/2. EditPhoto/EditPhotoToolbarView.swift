//
//  EditPhotoToolbarView.swift
//  TakePhoto
//
//  Created by Aaron Hanwe LEE on 5/20/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import Photos
import ArchiveFoundation
import UIComponents

public struct EditPhotoToolbarView: View {
  
  // MARK: - Private Property
  
  private let store: StoreOf<TakePhotoReducer>
  private let editCompleteAction: () -> Void
  private let editCancelAction: () -> Void
  
  // MARK: - Internal Property
  
  // MARK: - Life Cycle
  
  init(
    store: StoreOf<TakePhotoReducer>,
    editCompleteAction: @escaping () -> Void,
    editCancelAction: @escaping () -> Void
  ) {
    self.store = store
    self.editCompleteAction = editCompleteAction
    self.editCancelAction = editCancelAction
  }
  
  public var body: some View {
    
    WithViewStore(store, observe: { $0 }) { viewStore in
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
    
  }
  
  // MARK: - Private Method
  
  // MARK: - Internal Method
  
}
