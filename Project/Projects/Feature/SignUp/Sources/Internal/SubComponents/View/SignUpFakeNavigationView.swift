//
//  SignUpFakeNavigationView.swift
//  SignUp
//
//  Created by hanwe on 5/26/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import UIComponents
import ArchiveFoundation

struct SignUpFakeNavigationView: View {
  
  // MARK: - internal state
  
  // MARK: - private properties
  
  private let requestBackAction: () -> Void
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  init(
    requestBackAction: @escaping () -> Void
  ) {
    self.requestBackAction = requestBackAction
  }
  
  var body: some View {
    ZStack {
      Color.brown
      VStack {
        Button(action: {
          self.requestBackAction()
        }, label: {
          Text("뒤로가기")
        })
      }
    }
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
}
