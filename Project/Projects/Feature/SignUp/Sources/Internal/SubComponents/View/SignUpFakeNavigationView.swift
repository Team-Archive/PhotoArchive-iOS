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
  @Binding private var path: NavigationPath
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  init(
    path: Binding<NavigationPath>,
    requestBackAction: @escaping () -> Void
  ) {
    self._path = path
    self.requestBackAction = requestBackAction
  }
  
  var body: some View {
    ZStack {
      Text(L10n.Localizable.signUpNaviTitle)
        .font(.fonts(.bodyBold16))
        .foregroundStyle(Gen.Colors.white.color)
        .frame(alignment: .center)
      HStack {
        if path.count > 0 {
          Button.throttledAction(throttleTime: 1) {
            self.requestBackAction()
          } label: {
            Gen.Images.arrowLeft24.image
          }
        }
        Spacer()
      }
      .padding(.designContentsInset)
    }
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
}
