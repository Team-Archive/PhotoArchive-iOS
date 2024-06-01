//
//  TakePhotoNotPermittedView.swift
//  TakePhoto
//
//  Created by Aaron Hanwe LEE on 5/20/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import UIComponents

struct TakePhotoNotPermittedView: View {
  
  // MARK: - public state
  
  // MARK: - private properties
  
  // MARK: - public properties
  
  var action: () -> Void
  
  // MARK: - life cycle
  
  var body: some View {
    VStack {
      Button(action: {
        action()
      }, label: {
        Text("권한이 없어요 이거 눌러서 권한을 주세요")
      })
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
    TakePhotoNotPermittedView(action: {
      print("hola")
    })
  }
  
}
