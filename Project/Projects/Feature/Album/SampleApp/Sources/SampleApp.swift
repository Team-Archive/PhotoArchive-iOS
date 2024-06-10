//
//  App.swift
//  ArchiveFoundation
//
//  Created by hanwe on 1/28/24.
//  Copyright © 2024 Archive. All rights reserved.
//

import SwiftUI
import Album
import Domain
import UIComponents

@main
struct SampleApp: App {
  var body: some Scene {
    WindowGroup {
      AlbumView(
        reducer: AlbumReducer(
          albumType: .single(navigationTitle: L10n.Localizable.signUpSetProfilePhotoSelectTitle, completeButtonTitle: L10n.Localizable.commonComplete),
          albumUsecase: AlbumUsecaseImplement(recentAlbumName: "최근", favoriteAlbumName: "즐겨찾는 항목")
        ),
        complete: { imageList in
          print("selected: \(imageList)")
        },
        close: {
          print("close")
        })
    }
  }
}
