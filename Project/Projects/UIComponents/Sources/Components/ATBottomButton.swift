//
//  ATBottomButton.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 4/23/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI

public struct ATBottomButton: View {
  
  // MARK: - public state
  
  @Binding var isEnabled: Bool
  
  // MARK: - private properties
  
  private let title: String
  
  private var textColor: Color {
    if self.isEnabled {
      return Gen.Colors.white.color
    } else {
      return Gen.Colors.gray200.color
    }
  }
  
  private var backgroundColor: Color {
    if self.isEnabled {
      return Gen.Colors.purpleGray200.color
    } else {
      return Gen.Colors.purpleGray400.color
    }
  }
  
  private var font: Font {
    if self.isEnabled {
      return .fonts(.buttonExtraBold14)
    } else {
      return .fonts(.body14)
    }
  }
  
  
  // MARK: - public properties
  
  public var action: () -> Void
  
  // MARK: - life cycle
  
  public var body: some View {
    
    Button(action: {
      self.action()
    }, label: {
      HStack {
        Spacer()
        Text(self.title)
          .font(self.font)
          .foregroundStyle(self.textColor)
        Spacer()
      }
      .frame(height: 40)
      .background(self.backgroundColor)
      .clipShape(.rect(cornerRadius: 8))
      .padding([.leading, .trailing], .designContentsInset)
    })
    .disabled(!self.isEnabled)

  }
  
  public init(
    title: String,
    action: @escaping () -> Void,
    isEnabled: Binding<Bool> = .constant(true)
  ) {
    self.title = title
    self._isEnabled = isEnabled
    self.action = action
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
}

#Preview {
  VStack {
    ATBottomButton(title: "hola", action: {
      print("hola")
    })
  }
  
}
