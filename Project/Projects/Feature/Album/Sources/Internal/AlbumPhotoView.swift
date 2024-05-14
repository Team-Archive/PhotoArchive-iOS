//
//  AlbumPhotoView.swift
//  Album
//
//  Created by Aaron Hanwe LEE on 5/10/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import UIComponents
import Domain
import Photos
import ArchiveFoundation

public struct AlbumPhotoView: View {
  
  // MARK: - public state
  
  // MARK: - private properties
  
  private let album: Album
  private let itemInset: CGFloat = 3
  
  // MARK: - public properties
  
  public var action: (PHAsset) -> Void
  
  // MARK: - life cycle
  
  public var body: some View {
    
    ZStack {
      ATBackgroundView()
        .edgesIgnoringSafeArea(.all)
      GeometryReader { geometry in
        ScrollView {
          let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: self.itemInset), count: 3)
          LazyVGrid(columns: columns, spacing: self.itemInset) {
            ForEach(0..<self.album.fetchResult.count, id: \.self) { index in
              if let asset: PHAsset = self.album.fetchResult.object(at: index) as? PHAsset {
                ThumbnailView(asset: asset)
              }
            }
          }
        }
      }
    }
    
  }
  
  init(album: Album, selected: @escaping (PHAsset) -> Void) {
    self.album = album
    self.action = selected
  }
  
  // MARK: - private method
  
  @ViewBuilder
  private func ThumbnailView(asset: PHAsset) -> some View {
    Button(action: {
      self.action(asset)
    }, label: {
      VStack(alignment: .leading) {
        ATPHAssetImage(asset: asset, placeholder: Gen.Images.placeholder.image)
          .resizable()
          .scaledToFill()
          .aspectRatio(contentMode: .fill)
          .clipped()
      }
      .frame(maxHeight: .infinity)
    })
  }
  
  // MARK: - internal method
  
}

#Preview {
  VStack {
    AlbumPhotoView(album: .init(id: UUID(), name: "test", count: 10, fetchResult: .init(), thumbnailAsset: nil), selected: { selected in
      print("selected: \(selected)")
    })
  }
  
}
