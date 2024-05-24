//
//  PostingPhotoView.swift
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
import Lottie

public struct PostingPhotoView: View {
  
  // MARK: - Private Property
  
  private let store: StoreOf<TakePhotoReducer>
  
  // MARK: - Internal Property
  
  // MARK: - Life Cycle
  
  public init(
    store: StoreOf<TakePhotoReducer>
  ) {
    self.store = store
  }
  
  public var body: some View {
    
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack {
        LottieView {
          try await LottieAnimation.loadedFrom(url: <#T##URL#>)
        }
      }
    }
    
  }
  
  // MARK: - Private Method
  
  // MARK: - Internal Method
  
}
