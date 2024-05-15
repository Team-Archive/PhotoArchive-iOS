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
  private let selectedItemWidthHeight: CGFloat = 24
  
  // MARK: - public properties
  
  var completion: () -> Void
  
  // MARK: - life cycle
  
  var body: some View {
    
    WithViewStore(store, observe: { $0 }) { viewStore in
      ZStack {
        ATBackgroundView()
          .edgesIgnoringSafeArea(.all)
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
            FocusBoxView(asset: asset)
            SelectBoxView(asset: asset)
          }
        }
        .frame(maxHeight: .infinity)
      })
    }
    
  }
  
  @ViewBuilder
  private func SelectBoxView(asset: PHAsset) -> some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      ZStack(alignment: .topTrailing) {
        Rectangle()
          .fill(.clear)
          .border(viewStore.selectedAssetList.contains(asset) ? Gen.Colors.purple.color : .clear, width: 2)
        if viewStore.selectedAssetList.contains(asset) {
          SelectedItemNumberView(value: 1)
            .padding(8)
        } else {
          UnselectedItemNumberView()
            .frame(alignment: .topTrailing)
            .padding(8)
        }
      }
    }
  }
  
  @ViewBuilder
  private func SelectedItemNumberView(value: UInt) -> some View {
    ZStack {
      Circle()
        .fill(Gen.Colors.purple.color)
      Text("\(value)")
        .font(.fonts(.body14))
        .foregroundStyle(Gen.Colors.white.color)
    }
    .frame(width: self.selectedItemWidthHeight, height: self.selectedItemWidthHeight)
  }
  
  @ViewBuilder
  private func UnselectedItemNumberView() -> some View {
    Circle()
      .fill(Gen.Colors.white.color.opacity(0.8))
      .stroke(Gen.Colors.gray300.color, lineWidth: 2)
      .frame(width: self.selectedItemWidthHeight, height: self.selectedItemWidthHeight)
      .clipShape(.circle)
  }
  
  @ViewBuilder
  private func FocusBoxView(asset: PHAsset) -> some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      viewStore.selectedAssetList.contains(asset) ? Gen.Colors.gray200.color.opacity(0.3) : .clear
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

