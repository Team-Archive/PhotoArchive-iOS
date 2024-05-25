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
  @State private var rotationAngleList: [Double] = []
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  init(store: StoreOf<TakePhotoReducer>) {
    self.store = store
  }
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      GeometryReader { geometry in
        VStack(alignment: .center, spacing: 0) {
          if let assetList = viewStore.selectedPhotoFromAlbum {
            TabView(selection: $currentIndex) {
              ForEach(0..<assetList.count, id: \.self) { index in
                if let asset: PHAsset = assetList[safe: index] {
                  EditPhotoView(asset: asset, index: UInt(index))
                    .frame(
                      width: geometry.size.width - (.designContentsInset * 2),
                      height: geometry.size.width - (.designContentsInset * 2)
                    )
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: self.contentsViewCornerRadius))
                    .rotation3DEffect(
                      Angle(degrees: rotationAngleList[safe: index] ?? 0),
                      axis: (x: 0, y: 1, z: 0)
                    )
                    .animation(.easeInOut(duration: 0.4), value: rotationAngleList[safe: index])
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
            .onChange(of: currentIndex, initial: true, { oldValue, newValue in
              if self.rotationAngleList.count > newValue {
                if oldValue < newValue {
                  rotationAngleList[newValue] = 0
                  rotationAngleList[oldValue] = 45
                } else if oldValue > newValue {
                  rotationAngleList[newValue] = 0
                  rotationAngleList[oldValue] = -45
                }
              }
              viewStore.send(.setCurrentPhotoFromAlbumIndex(UInt(newValue)))
            })
            .onAppear {
              self.rotationAngleList = {
                var returnValue: [Double] = [0]
                for _ in 0..<(viewStore.selectedPhotoFromAlbum?.count ?? 0) - 1 {
                  returnValue.append(-45)
                }
                return returnValue
              }()
            }
          } else {
            Text("Unexpected Error :(")
          }
          Spacer()
            .frame(height: 12)
          if let assetList = viewStore.selectedPhotoFromAlbum {
            ATPageIndicator(numberOfPages: assetList.count, currentPage: $currentIndex)
              .frame(width: 200) // TODO: 넓이 조정이 안되네...
          }
          Spacer()
            .frame(height: 20)
          EditPhotoToolbarView(
            store: self.store,
            editCompleteAction: {
              viewStore.send(.setIsCompleteEditPhoto(true))
            },
            editCancelAction: {
              viewStore.send(.clearSelectedPhoto)
            }
          )
        }
      }
    }
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
