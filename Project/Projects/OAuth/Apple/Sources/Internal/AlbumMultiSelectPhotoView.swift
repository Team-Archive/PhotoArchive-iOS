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
import Combine

struct AlbumMultiSelectPhotoView: View {
  
  // MARK: - public state
  
  // MARK: - private properties
  
  private let store: StoreOf<AlbumReducer>
  private let itemInset: CGFloat = 3
  private let maxSelectableCount: UInt
  private let selectedItemWidthHeight: CGFloat = 24
  @State private var shakeTrigger: UInt?
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  var body: some View {
    
    WithViewStore(store, observe: { $0 }) { viewStore in
      ZStack {
        ATBackgroundView()
          .edgesIgnoringSafeArea(.all)
        ScrollView {
          let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: self.itemInset), count: 3)
          LazyVGrid(columns: columns, spacing: self.itemInset) {
            ForEach(0..<viewStore.albumAssetList.count, id: \.self) { index in
              if let asset: PHAsset = viewStore.albumAssetList[safe: index] {
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
    maxSelectableCount: UInt = 10
  ) {
    self.store = store
    self.maxSelectableCount = maxSelectableCount
  }
  
  // MARK: - private method
  
  @ViewBuilder
  private func ThumbnailView(asset: PHAsset, index: UInt) -> some View {
    
    WithViewStore(store, observe: { $0 }) { viewStore in
      Button(action: {
        if viewStore.selectedAssetList.contains(asset) {
          viewStore.send(.removeSelectedAsset(asset))
        } else {
          if viewStore.selectedAssetList.count + 1 > self.maxSelectableCount {
            withAnimation {
              shakeTrigger = index
              let generator = UINotificationFeedbackGenerator()
              generator.notificationOccurred(.error)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
              shakeTrigger = nil
            }
          } else {
            viewStore.send(.appendSelectedAsset(asset))
          }
        }
      }, label: {
        VStack(alignment: .leading) {
          ZStack {
            ATPHAssetImage(asset: asset, placeholder: Gen.Images.placeholder.image)
              .resizable()
              .scaledToFill()
              .aspectRatio(contentMode: .fill)
              .clipped()
              .id(asset.localIdentifier)
              .modifier(WarningEffect(shakeTrigger == index ? 1 : 0))
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
          let selectedIndex: UInt = {
            if let index = self.selectedIndex(list: viewStore.selectedAssetList, asset: asset) {
              return index + 1
            } else {
              return 0
            }
          }()
          SelectedItemNumberView(value: selectedIndex)
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
  
  private func selectedIndex(list: [PHAsset], asset: PHAsset) -> UInt? {
    if list.contains(asset) {
      for i in 0..<list.count {
        guard let item = list[safe: i] else { continue }
        if item == asset {
          return UInt(i)
        }
      }
      return nil
    } else {
      return nil
    }
  }
  
  // MARK: - internal method
  
}


#Preview {
  VStack {
    AlbumMultiSelectPhotoView(
      store: .init(
        initialState: .init(),
        reducer: {
          
        })
    )
  }
  
}

