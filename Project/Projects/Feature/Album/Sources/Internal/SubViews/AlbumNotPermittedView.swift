//
//  AlbumNotPermittedView.swift
//  Album
//
//  Created by Aaron Hanwe LEE on 5/10/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import UIComponents

struct AlbumNotPermittedView: View {
  
  // MARK: - public state
  
  // MARK: - private properties
  
  // MARK: - public properties
  
  var action: () -> Void
  
  // MARK: - life cycle
  
  var body: some View {
    VStack(spacing: 20) {
      Spacer()
      ContentsView()
      Spacer()
      Spacer()
      Text(L10n.Localizable.albumNotPermittedHelp)
        .font(.fonts(.body14))
        .foregroundStyle(Gen.Colors.gray300.color)
        .multilineTextAlignment(.center)
      ATBottomActionButton(title: L10n.Localizable.albumNotPermittedAllowButtonTitle, action: {
        action()
      })
    }
  }
  
  init(action: @escaping () -> Void) {
    self.action = action
  }
  
  // MARK: - private method
  
  @ViewBuilder
  private func ContentsView() -> some View {
    VStack(spacing: 20) {
      Gen.Images.requestAlbumPermission.image
        .frame(width: 80, height: 65)
      Text(L10n.Localizable.albumNotPermittedTitle)
        .font(.fonts(.title24))
        .foregroundStyle(Gen.Colors.white.color)
        .multilineTextAlignment(.center)
      Text(L10n.Localizable.albumNotPermittedContents)
        .font(.fonts(.body14))
        .foregroundStyle(Gen.Colors.gray300.color)
        .multilineTextAlignment(.center)
    }
    .padding(
      .init(
        top: 0,
        leading: .designContentsInset,
        bottom: 0,
        trailing: .designContentsInset
      )
    )
  }
  
  // MARK: - internal method
  
}

#Preview {
  VStack {
    AlbumNotPermittedView(action: {
      print("hola")
    })
  }
  
}
