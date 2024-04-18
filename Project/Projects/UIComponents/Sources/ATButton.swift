//
//  ATButton.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 4/16/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI

public struct ATButton: View {
  
  public enum ButtonType {
    case primary
  }
  
  // MARK: - public state
  
  // MARK: - private properties
  
  private let type: ButtonType
  private let title: String
  
  // MARK: - public properties
  
  public var action: () -> Void
  
  // MARK: - life cycle
  
  public var body: some View {
    
    Button(action: {
      self.action()
    }, label: {
//      HStack {
//        Spacer()
//        self.type.iconImage
//          .renderingMode(.original)
//        Text(self.type.contents)
//          .font(.fonts(.sample))
//          .foregroundStyle(self.type.textColor)
//        Spacer()
//      }
//      .frame(height: 56)
//      .background(self.type.backgroundColor)
//      .clipShape(.rect(cornerRadius: 28))
//      .overlay(
//        RoundedRectangle(cornerRadius: 28)
//          .stroke(self.type.borderColor, lineWidth: 1)
//      )
//      .padding([.leading, .trailing], 20)
      Text(title)
        .font(.fonts(.buttonSemiBold14))
    })

  }
  
  public init(
    type: ButtonType = .primary,
    title: String,
    action: @escaping () -> Void
  ) {
    self.type = type
    self.title = title
    self.action = action
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
}

#Preview {
  VStack {
    ATButton(type: .primary, title: "hola", action: {
      print("apple!")
    })
  }
  
}
