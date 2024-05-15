//
//  AlbumMultiSelectPhotoView.swift
//  Album
//
//  Created by Aaron Hanwe LEE on 5/10/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import UIComponents
import Domain
import Photos
import ArchiveFoundation

struct AlbumMultiSelectPhotoView: View {
  
  // MARK: - public state
  
  // MARK: - private properties
  
  private let store: StoreOf<AlbumReducer>
  private let album: Album
  private let itemInset: CGFloat = 3
  private let maxSelectableCount: UInt
  
  // MARK: - public properties
  
  var completion: () -> Void
  
  // MARK: - life cycle
  
  var body: some View {
    
    WithViewStore(store, observe: { $0 }) { viewStore in
      ZStack {
        ATBackgroundView()
          .edgesIgnoringSafeArea(.all)
        GeometryReader { geometry in
          ScrollView {
            let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: self.itemInset), count: 3)
            LazyVGrid(columns: columns, spacing: self.itemInset) {
              ForEach(0..<self.album.fetchResult.count, id: \.self) { index in
                if let asset: PHAsset = self.album.fetchResult.object(at: index) as? PHAsset {
                  ThumbnailView(
                    asset: asset, 
                    index: UInt(index)
                  )
                }
              }
            }
          }
        }
      }
    }
    
  }
  
  init(
    store: StoreOf<AlbumReducer>,
    album: Album,
    maxSelectableCount: UInt = 10,
    completion: @escaping () -> Void
  ) {
    self.store = store
    self.album = album
    self.maxSelectableCount = maxSelectableCount
    self.completion = completion
  }
  
  // MARK: - private method
  
  @ViewBuilder
  private func ThumbnailView(asset: PHAsset, index: UInt) -> some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      Button(action: {
        if viewStore.selectedAssetList.contains(asset) {
          if let currentFocusIndex = viewStore.currentFocusIndex {
            if currentFocusIndex == index {
              viewStore.send(.removeSelectedAsset(asset))
            }
          }
        } else {
          viewStore.send(.appendSelectedAsset(asset))
        }
        viewStore.send(.setCurrentFocusIndex(index))
      }, label: {
        VStack(alignment: .leading) {
          ZStack {
            ATPHAssetImage(asset: asset, placeholder: Gen.Images.placeholder.image)
              .resizable()
              .scaledToFill()
              .aspectRatio(contentMode: .fill)
              .clipped()
          }
        }
        .frame(maxHeight: .infinity)
      })
    }
    
  }
  
  // MARK: - internal method
  
}


//#Preview {
//  VStack {
//    AlbumMultiSelectPhotoView(
//      reducer: <#AlbumReducer#>, album: .init(id: UUID(), name: "test", count: 10, fetchResult: .init(), thumbnailAsset: nil),
//      completion: { selected in
//      print("selected: \(selected)")
//    })
//  }
//  
//}

