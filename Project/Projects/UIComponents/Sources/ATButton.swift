//
//  ATButton.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 4/16/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI

public struct ATButton: View {
  
  // MARK: - public state
  
  @Binding var isEnabled: Bool
  
  // MARK: - private properties
  
  private let title: String
  
  private var textColor: Color {
    if self.isEnabled {
      return Gen.Colors.purpleGray400.swiftUIColor
    } else {
      return Gen.Colors.gray200.swiftUIColor
    }
  }
  
  private var backgroundColor: Color {
    if self.isEnabled {
      return Gen.Colors.white.swiftUIColor
    } else {
      return Gen.Colors.purpleGray400.swiftUIColor
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
        Text(self.title)
          .font(self.font)
          .foregroundStyle(self.textColor)
          .padding(26)
      }
      .frame(height: 36)
      .background(self.backgroundColor)
      .clipShape(.rect(cornerRadius: 18))
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
    ATButton(title: "hola", action: {
      print("hola")
    })
  }
  
}
