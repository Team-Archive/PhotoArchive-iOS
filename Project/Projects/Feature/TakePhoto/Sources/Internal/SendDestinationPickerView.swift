//
//  SendDestinationPickerView.swift
//  TakePhoto
//
//  Created by Aaron Hanwe LEE on 5/23/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import UIComponents
import ArchiveFoundation

struct SendDestinationPickerView: View {
  
  // MARK: - public state
  
  // MARK: - private properties
  
  private let candidateList: [UserInformation]
  
  // MARK: - public properties
  
  var action: ([UserInformation]) -> Void
  
  // MARK: - life cycle
  
  var body: some View {
    ZStack {
      Gen.Colors.purpleGray400.color
        .ignoresSafeArea(.all)
      VStack {
        Text(L10n.Localizable.takePhotoSendToTitle)
          .font(.fonts(.body16))
          .foregroundStyle(Gen.Colors.white.color)
      }
      ATBottomActionButton(
        icon: Gen.Images.send24.image,
        title: L10n.Localizable.takePhotoSendToButtonTitle,
        action: {
          print("ㅇㅇ?")
        },
        isEnabled: .constant(true) // FIXME: 개발해야함
      )
    }
  }
  
  init(
    candidateList: [UserInformation],
    action: @escaping ([UserInformation]) -> Void
  ) {
    self.candidateList = candidateList
    self.action = action
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
}

#Preview {
  VStack {
    SendDestinationPickerView(candidateList: []) { list in
      print("selected: \(list)")
    }
  }
  
}
