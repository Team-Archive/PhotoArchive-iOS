//
//  PhotoSelectorFactory.swift
//  Album
//
//  Created by Aaron Hanwe LEE on 6/10/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import ArchiveFoundation
import Photos

final class PhotoSelectorFactory {
  
  @ViewBuilder
  static func makePhotoSelector(
    store: StoreOf<AlbumReducer>,
    type: AlbumReducer.AlbumType,
    isShowAlbumSelector: Binding<Bool>,
    complete: @escaping ([PHAsset]) -> Void,
    close: @escaping () -> Void
  ) -> some View {
    switch type {
    case .multi(let maxSelectableCount):
      AlbumMultiSelectPhotoView(
        store: store,
        maxSelectableCount: maxSelectableCount,
        isShowAlbumSelector: isShowAlbumSelector,
        complete: complete,
        close: close
      )
    case .single(let navigationTitle, let completeButtonTitle):
      AlbumSingleSelectPhotoView(
        store: store,
        isShowAlbumSelector: isShowAlbumSelector,
        navigationTitle: navigationTitle,
        completeButtonTitle: completeButtonTitle,
        complete: complete,
        close: close
      )
    }
  }
  
}
