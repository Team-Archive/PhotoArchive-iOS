//
//  PhotoPickerWrapperView.swift
//  App
//
//  Created by hanwe on 10/20/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import AppRoute
import Domain
import Data
import DomainInterface
import ArchiveFoundation
import Album
import Photos
import UIComponents

public struct PhotoPickerWrapperView: View, PhotoPicker {
  
  // MARK: - Private Property
  
  let hostView: AlbumView
  
  // MARK: - Internal Property
  
  // MARK: - Life Cycle
  
  public init(
    completeAction: @escaping ([PHAsset]) -> Void,
    closeAction: @escaping () -> Void
  ) {
    self.hostView = AlbumView(
      reducer: AlbumReducer(
        albumType: .single(
          navigationTitle: L10n.Localizable.signUpSetProfileTitle,
          completeButtonTitle: L10n.Localizable.commonComplete
        ),
        albumUsecase: AlbumUsecaseImplement(
          recentAlbumName: L10n.Localizable.albumRecentAlbum,
          favoriteAlbumName: L10n.Localizable.albumFavoriteAlbum
        )
      ),
      complete: { assetList in
        completeAction(assetList)
      },
      close: {
        closeAction()
      }
    )
  }
  
  public var body: some View {
    hostView
  }
  
  // MARK: - Private Method
  
  // MARK: - Internal Method
  
}
