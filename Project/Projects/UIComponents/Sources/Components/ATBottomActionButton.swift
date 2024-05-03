//
//  ATBottomActionButton.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 4/23/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI

public struct ATBottomActionButton: View {
  
  // MARK: - public state
  
  @Binding var isEnabled: Bool
  
  // MARK: - private properties
  
  private let icon: Image
  private let title: String
  
  private var textColor: Color {
    if self.isEnabled {
      return Gen.Colors.white.color
    } else {
      return Gen.Colors.gray200.color
    }
  }
  
  private var backgroundStartColor: Color {
    if self.isEnabled {
      return Gen.Colors.gradationMainStart.color
    } else {
      return Gen.Colors.purpleGray400.color
    }
  }
  
  private var backgroundEndColor: Color {
    if self.isEnabled {
      return Gen.Colors.gradationMainEnd.color
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
      ZStack {
        LinearGradient(
          gradient: Gradient(
            colors: [
              self.backgroundStartColor,
              self.backgroundEndColor
            ]),
          startPoint: .top,
          endPoint: .bottom
        )
        HStack(spacing: 4) {
          Spacer()
          self.icon
            .renderingMode(.template)
            .tint(self.textColor)
            .frame(width: 20, height: 20)
          Text(self.title)
            .font(self.font)
            .foregroundStyle(self.textColor)
          Spacer()
        }
      }
      .frame(height: 52)
      .clipShape(.rect(cornerRadius: 26))
      .padding([.leading, .trailing], .designContentsInset)
    })
    .disabled(!self.isEnabled)

  }
  
  public init(
    icon: Image,
    title: String,
    action: @escaping () -> Void,
    isEnabled: Binding<Bool> = .constant(true)
  ) {
    self.icon = icon
    self.title = title
    self._isEnabled = isEnabled
    self.action = action
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
}

#Preview {
  VStack {
    ATBottomActionButton(icon: .init(systemName: "bolt"), title: "hola", action: {
      print("hola")
    })
  }
  
}
