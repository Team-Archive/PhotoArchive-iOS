//
//  ContentView.swift
//  ArchiveFoundation
//
//  Created by hanwe on 1/28/24.
//  Copyright © 2024 Archive. All rights reserved.
//

import SwiftUI
import Domain
import Photos

struct ContentView: View {
  
  let albumUsecase = AlbumUsecaseImplement(recentAlbumName: "최근", favoriteAlbumName: "즐겨찾는 항목")
  
  var body: some View {
    
    Button(action: {
      PHPhotoLibrary.requestAuthorization { status in
        if status == .authorized {
        } else {
          print("Photos access was denied.")
        }
      }
    }, label: {
      Text("사진첩권한요청")
    })
    
    Button(action: {
      let list = self.albumUsecase.fetchAlbumList()
      print("list: \(list)")
      
    }, label: {
      Text("앨범테스트")
    })
  }
  
  
}

#Preview {
  ContentView()
}
