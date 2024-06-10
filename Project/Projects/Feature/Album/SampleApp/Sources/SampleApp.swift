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
  
  @State private var isShowMultiPhoto: Bool = false
  @State private var isShowSinglePhoto: Bool = false
  
  var body: some Scene {
    WindowGroup {
      
        VStack {
          Button(action: {
            self.isShowMultiPhoto = true
          }, label: {
            Text("멀티")
          })
          
          Button(action: {
            self.isShowSinglePhoto = true
          }, label: {
            Text("싱글")
          })
        }
        .navigationTitle("앨범 샘플")
        .toolbarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $isShowSinglePhoto) {
          AlbumView(
            reducer: AlbumReducer(
              albumType: .single(navigationTitle: L10n.Localizable.signUpSetProfilePhotoSelectTitle, completeButtonTitle: L10n.Localizable.commonComplete),
              albumUsecase: AlbumUsecaseImplement(recentAlbumName: "최근", favoriteAlbumName: "즐겨찾는 항목")
            ),
            complete: { imageList in
              print("selected: \(imageList)")
            },
            close: {
              self.isShowSinglePhoto = false
            })
        }
        .fullScreenCover(isPresented: $isShowMultiPhoto) {
          AlbumView(
            reducer: AlbumReducer(
              albumType: .multi(maxSelectableCount: UInt(10)),
              albumUsecase: AlbumUsecaseImplement(recentAlbumName: "최근", favoriteAlbumName: "즐겨찾는 항목")
            ),
            complete: { imageList in
              print("selected: \(imageList)")
            },
            close: {
              self.isShowMultiPhoto = false
            })
        }
      
    }
  }
}
