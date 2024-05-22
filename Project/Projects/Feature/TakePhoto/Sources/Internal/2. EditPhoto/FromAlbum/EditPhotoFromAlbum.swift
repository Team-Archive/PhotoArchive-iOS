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
  @State private var currentIndex: Int = 0
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      GeometryReader { geometry in
        VStack(alignment: .center, spacing: 0) {
          if let assetList = viewStore.selectedPhotoFromAlbum {
            TabView(selection: $currentIndex) { // TODO: 페이지 넘기는 애니메이션 적용?
              ForEach(0..<assetList.count, id: \.self) { index in
                if let asset: PHAsset = assetList[safe: index] {
                  EditPhotoView(asset: asset, index: UInt(index))
                    .frame(
                      width: geometry.size.width - (.designContentsInset * 2),
                      height: geometry.size.width - (.designContentsInset * 2)
                    )
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: self.contentsViewCornerRadius))
                } else {
                  Text("Asset not found :(")
                    .frame(
                      width: geometry.size.width - (.designContentsInset * 2),
                      height: geometry.size.width - (.designContentsInset * 2)
                    )
                }
              }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onChange(of: currentIndex, initial: true, { oldValue, newValue in
              viewStore.send(.setCurrentPhotoFromAlbumIndex(UInt(newValue)))
            })
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
          Spacer()
            .frame(height: 12)
          if let assetList = viewStore.selectedPhotoFromAlbum {
            ATPageIndicator(numberOfPages: assetList.count, currentPage: $currentIndex)
              .frame(width: 200)
          }
          Spacer()
            .frame(height: 20)
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
  
  @ViewBuilder
  private func EditPhotoView(asset: PHAsset, index: UInt) -> some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      GeometryReader { geometry in
        ZStack {
          ATPHAssetImage(asset: asset, placeholder: Gen.Images.placeholder.image)
            .resizable()
            .scaledToFill()
            .aspectRatio(contentMode: .fill)
            .clipped()
          VStack() {
            Spacer()
            ATInputView(
              placeholder: L10n.Localizable.takePhotoEditTextInputPlaceholder,
              message: Binding(
                get: {
                  viewStore.state.candidateContentsFromAlbum[asset] ?? ""
                },
                set: { newValue in
                  viewStore.send(.setCandidateContentsFromAlbum(asset: asset, contents: newValue))
                }
              ),
              Int(viewStore.maxTextInputCount)
            )
            .padding(.bottom, 20)
          }
        }
      }
    }
  }
  
  // MARK: - internal method
  
}
