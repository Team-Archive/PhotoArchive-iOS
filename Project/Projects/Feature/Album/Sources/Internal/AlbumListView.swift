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
import ArchiveFoundation

struct AlbumListView: View {
  
  // MARK: - public state
  
  // MARK: - private properties
  
  @State private var stackPath: NavigationPath = .init()
  @Binding var isPresented: Bool
  private let albumList: [Album]
  private let itemRightInset: CGFloat = 16
  private let itemBottomInset: CGFloat = 20
  private let contentsHeight: CGFloat = 46
  
  // MARK: - public properties
  
  var action: (Album) -> Void
  
  // MARK: - life cycle
  
  var body: some View {
    
    GeometryReader { geometry in
      NavigationStack(path: $stackPath) {
        ZStack {
          ATBackgroundView()
            .edgesIgnoringSafeArea(.all)
          ScrollView {
            let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: self.itemRightInset), count: 2)
            LazyVGrid(columns: columns, spacing: self.itemBottomInset) {
              ForEach(self.albumList) { album in
                albumThumbnailView(album: album)
                  .frame(
                    width: (geometry.size.width - self.itemRightInset - (.designContentsInset * 2)) / 2,
                    height: ((geometry.size.width - self.itemRightInset - (.designContentsInset * 2)) / 2) + contentsHeight
                  )
                  .aspectRatio(1, contentMode: .fit)
              }
            }
          }.padding(
            EdgeInsets(
              top: 0,
              leading: .designContentsInset,
              bottom: 0,
              trailing: .designContentsInset
            )
          )
        }
        .toolbar {
          ToolbarItem(placement: .topBarTrailing) {
            Button(action: {
              self.isPresented = false
            }) {
              Gen.Images.close.image
                .renderingMode(.template)
                .foregroundStyle(Gen.Colors.white.color)
            }
          }
        }
      }
    }
    
  }
  
  init(
    albumList: [Album],
    isPresented: Binding<Bool>,
    selected: @escaping (Album) -> Void
  ) {
    self.albumList = albumList
    self._isPresented = isPresented
    self.action = selected
  }
  
  // MARK: - private method
  
  @ViewBuilder
  private func albumThumbnailView(album: Album) -> some View {
    Button(action: {
      self.action(album)
    }, label: {
      VStack(alignment: .leading) {
        ATPHAssetImage(asset: album.thumbnailAsset, placeholder: Gen.Images.placeholder.image)
          .resizable()
          .scaledToFill()
          .aspectRatio(contentMode: .fill)
          .clipShape(.rect(cornerRadius: 8))
          .clipped()
        Spacer(minLength: 8)
        Text(album.name)
          .font(.fonts(.body14))
          .foregroundStyle(Gen.Colors.white.color)
        Spacer(minLength: 4)
        Text(album.count.toDotString())
          .font(.fonts(.body14))
          .foregroundStyle(Gen.Colors.gray300.color)
      }
      .frame(maxHeight: .infinity)
    })
  }
  
  // MARK: - internal method
  
}

#Preview {
  VStack {
    AlbumListView(albumList: [], isPresented: .constant(true), selected: { selected in
      print("selected: \(selected)")
    })
  }
  
}
