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
  private var lottiePlaybackMode: LottiePlaybackMode = .playing(.fromProgress(nil, toProgress: 1, loopMode: .loop))
  
  @State var isOnAppear: Bool = false
  
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
        Color.clear
      }
      .onAppear {
        DispatchQueue.main.async {
          UIView.setAnimationsEnabled(false)
          self.isOnAppear = true
        }
      }
      .fullScreenCover(isPresented: $isOnAppear) {
        uploadingView()
          .onAppear {
            UIView.setAnimationsEnabled(true)
          }
      }
    }
    
  }
  
  // MARK: - Private Method
  
  @ViewBuilder
  private func uploadingView() -> some View {
    VStack {
      LottieView(animation: AnimationAsset.upload.animation)
        .resizable()
        .playbackMode(lottiePlaybackMode)
        .getRealtimeAnimationProgress(.constant(200))
        .frame(width: 100, height: 100)
      Text("업로드 중입니다.")
    }
  }
  
  // MARK: - Internal Method
  
}
