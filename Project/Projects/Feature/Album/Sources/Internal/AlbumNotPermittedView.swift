//
//  AlbumNotPermittedView.swift
//  Album
//
//  Created by Aaron Hanwe LEE on 5/10/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import UIComponents

public struct AlbumNotPermittedView: View {
  
  // MARK: - public state
  
  // MARK: - private properties
  
  // MARK: - public properties
  
  public var action: () -> Void
  
  // MARK: - life cycle
  
  public var body: some View {
    
    VStack {
      Text("권한이 없어요 ~")
      Button("설정으로 갑시다") {
        self.action()
      }
    }

  }
  
  init(action: @escaping () -> Void) {
    self.action = action
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
}

#Preview {
  VStack {
    AlbumNotPermittedView(action: {
      print("hola")
    })
  }
  
}
