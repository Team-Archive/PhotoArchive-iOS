//
//  CompletePostingPhotoView.swift
//  TakePhoto
//
//  Created by Aaron Hanwe LEE on 5/24/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import Photos
import ArchiveFoundation
import UIComponents
import AppRoute

public struct CompletePostingPhotoView: View {
  
  // MARK: - Private Property
  
  private let store: StoreOf<TakePhotoReducer>
  private let action: () -> Void
  
  // MARK: - Internal Property
  
  // MARK: - Life Cycle
  
  public init(
    store: StoreOf<TakePhotoReducer>,
    completeAction: @escaping () -> Void
  ) {
    self.store = store
    self.action = completeAction
  }
  
  public var body: some View {
    
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack {
        Color.clear
      }
      .fullScreenCover(isPresented: .constant(true)) {
        completeUploadView()
      }
    }
    
  }
  
  // MARK: - Private Method
  
  @ViewBuilder
  private func completeUploadView() -> some View {
    Text("업로드 완료")
    Button(action: {
      self.action()
    }, label: {
      Text("확인")
    })
  }
  
  // MARK: - Internal Method
  
}
