//
//  EditPhotoFromAlbum.swift
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
import Photos

struct EditPhotoFromAlbum: View {
  
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
          if let assetList = viewStore.selectedPhotoFromAlbum {
            TabView {
              ForEach(0..<assetList.count, id: \.self) { index in
                if let asset: PHAsset = assetList[safe: index] {
                  EditPhotoView(asset: asset, index: UInt(index))
                    .frame(
                      width: geometry.size.width - (.designContentsInset * 2),
                      height: geometry.size.width - (.designContentsInset * 2)
                    )
                } else {
                  Text("Asset not found :(")
                    .frame(
                      width: geometry.size.width - (.designContentsInset * 2),
                      height: geometry.size.width - (.designContentsInset * 2)
                    )
                }
              }
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(
              width: geometry.size.width - (.designContentsInset * 2),
              height: geometry.size.width - (.designContentsInset * 2)
            )
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: self.contentsViewCornerRadius))
            .padding(
              .init(
                top: 0,
                leading: .designContentsInset,
                bottom: 0,
                trailing: .designContentsInset
              )
            )
          } else {
            Text("Unexpected Error :(")
          }
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
    UIPageControl.appearance().currentPageIndicatorTintColor = Gen.Colors.purple.uikitColor
    UIPageControl.appearance().pageIndicatorTintColor = Gen.Colors.white.uikitColor
  }
  
  // MARK: - private method
  
  @ViewBuilder
  private func EditPhotoView(asset: PHAsset, index: UInt) -> some View {
    VStack(alignment: .leading) {
      ZStack {
        ATPHAssetImage(asset: asset, placeholder: Gen.Images.placeholder.image)
          .resizable()
          .scaledToFill()
          .aspectRatio(contentMode: .fill)
          .clipped()
          .id(asset.localIdentifier)
      }
    }
    .frame(maxHeight: .infinity)
  }
  
  // MARK: - internal method
  
}
