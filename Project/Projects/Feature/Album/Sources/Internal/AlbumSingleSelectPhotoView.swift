//
//  AlbumSingleSelectPhotoView.swift
//  Album
//
//  Created by hanwe on 5/15/24.
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

struct AlbumSingleSelectPhotoView: View {
  
  // MARK: - public state
  
  // MARK: - private properties
  
  private let store: StoreOf<AlbumReducer>
  private let itemInset: CGFloat = 3
  private let selectedItemWidthHeight: CGFloat = 24
  @Binding var isShowAlbumSelector: Bool
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  var body: some View {
    
    WithViewStore(store, observe: { $0 }) { viewStore in
      GeometryReader { geometry in
        VStack {
          PreviewView(asset: viewStore.selectedAssetList.first)
            .frame(
              width: geometry.size.width,
              height: geometry.size.width
            )
          AlbumSelectView()
          PhotoListView()
        }
      }
    }
    
  }
  
  init(
    store: StoreOf<AlbumReducer>,
    isShowAlbumSelector: Binding<Bool>
  ) {
    self.store = store
    self._isShowAlbumSelector = isShowAlbumSelector
  }
  
  // MARK: - private method
  
  @ViewBuilder
  private func PreviewView(asset: PHAsset?) -> some View {
    
    WithViewStore(store, observe: { $0 }) { viewStore in
      ZStack {
        if let selectedAsset = viewStore.selectedAssetList.first {
          ATPHAssetImage(
            asset: asset,
            placeholder: nil,
            photoType: .detail
          )
          .id(selectedAsset.localIdentifier)
        } else {
          Gen.Images.user24.image // FIXME: 이미지 변경해야함
            .resizable()
            .scaledToFill()
        }
        Gen.Images.photoExclude.image
          .resizable()
          .scaledToFill()
      }
    }
  }
  
  @ViewBuilder
  private func AlbumSelectView() -> some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      Button(action: {
        self.isShowAlbumSelector = true
      }, label: {
        HStack(spacing: 4) {
          Text(viewStore.selectedAlbum?.name ?? "-")
            .font(.fonts(.bodyBold16))
            .foregroundStyle(Gen.Colors.white.color)
          Gen.Images.arrowMini.image
            .resizable()
            .frame(width: 16, height: 16)
            .rotationEffect(.degrees(90))
          Spacer()
        }
      })
      .frame(height: 54)
      .padding(
        .init(
          top: 0,
          leading: .designContentsInset,
          bottom: 0,
          trailing: .designContentsInset
        )
      )
    }
  }
  
  @ViewBuilder
  private func PhotoListView() -> some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
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
  
  @ViewBuilder
  private func ThumbnailView(asset: PHAsset, index: UInt) -> some View {
    
    WithViewStore(store, observe: { $0 }) { viewStore in
      Button(action: {
        if !viewStore.selectedAssetList.contains(asset) {
          if let lastAsset = viewStore.selectedAssetList.first {
            viewStore.send(.removeSelectedAsset(lastAsset))
          }
          viewStore.send(.appendSelectedAsset(asset))
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
            
            Rectangle()
              .fill(.clear)
              .border(viewStore.selectedAssetList.contains(asset) ? Gen.Colors.purple.color : .clear, width: 2)
          }
        }
        .frame(maxHeight: .infinity)
      })
    }
    
  }
  
  // MARK: - internal method
  
}
