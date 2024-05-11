//
//  AlbumListView.swift
//  Album
//
//  Created by Aaron Hanwe LEE on 5/10/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import UIComponents
import Domain
import Photos

public struct AlbumListView: View {
  
  //  private struct AlbumThumbnailInfo: Identifiable {
  //    let id: UUID
  //    let name: String
  //    let image: Image
  //  }
  
  // MARK: - public state
  
  // MARK: - private properties
  
  private let albumList: [Album]
  @State private var viewModels: [UUID: AlbumThumbnailViewModel] = [:]
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  public var body: some View {
    
    ZStack {
      List {
        ForEach(self.albumList) { album in
          HStack {
            //            album.thumbnailAsset?.toImage(size: .init(width: 200, height: 200))
            if let thumbnailAsset = album.thumbnailAsset {
              albumThumbnailView(asset: thumbnailAsset, id: album.id)
            } else {
              Text("No Thumbnail")
            }
          }
        }
      }
      .listStyle(.plain)
    }
    
  }
  
  init(albumList: [Album]) {
    self.albumList = albumList
    
  }
  
  // MARK: - private method
  
  @ViewBuilder
  private func albumThumbnailView(asset: PHAsset, id: UUID) -> some View {
    let viewModel = viewModels[id, default: AlbumThumbnailViewModel(asset: asset)]
    if let image = viewModel.image {
      image
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: 200, height: 200)
    } else if let errorMessage = viewModel.errorMessage {
      Text(errorMessage)
    } else {
      ProgressView()
    }
  }
  
  // MARK: - internal method
  
}

class AlbumThumbnailViewModel: ObservableObject {
  @Published var image: Image?
  @Published var errorMessage: String?
  
  private var asset: PHAsset
  
  init(asset: PHAsset) {
    self.asset = asset
    loadImage()
  }
  
  func loadImage() {
    Task {
      let result = await asset.toImage(.thumbnail)
      switch result {
      case .success(let img):
        DispatchQueue.main.async {
          self.image = img
          self.errorMessage = nil
        }
      case .failure(_):
        DispatchQueue.main.async {
          self.errorMessage = "Failed to load image."
        }
      }
    }
  }
}

#Preview {
  VStack {
    AlbumListView(albumList: [])
  }
  
}
