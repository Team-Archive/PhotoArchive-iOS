//
//  ATRoundIconButton.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 4/23/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//
import SwiftUI

public struct ATRoundIconButton: View {
  
  // MARK: - public state
  
  @Binding var isEnabled: Bool
  
  // MARK: - private properties
  
  private let icon: Image
  private let borderColor: Color
  private let borderWidth: CGFloat
  
  private var backgroundStartColor: Color {
    if self.isEnabled {
      return UIComponentsAsset.Colors.gradationMainStart.swiftUIColor
    } else {
      return UIComponentsAsset.Colors.purpleGray400.swiftUIColor
    }
  }
  
  private var backgroundEndColor: Color {
    if self.isEnabled {
      return UIComponentsAsset.Colors.gradationMainEnd.swiftUIColor
    } else {
      return UIComponentsAsset.Colors.purpleGray400.swiftUIColor
    }
  }
  
  private var iconColor: Color {
    if self.isEnabled {
      return UIComponentsAsset.Colors.white.swiftUIColor
    } else {
      return UIComponentsAsset.Colors.gray200.swiftUIColor
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
        self.icon
          .renderingMode(.template)
          .tint(self.iconColor)
      }
      .clipShape(.circle)
      .overlay(
        Circle()
          .stroke(self.borderColor, lineWidth: self.borderWidth)
          .opacity(0.5)
      )
    })
    .disabled(!self.isEnabled)

  }
  
  public init(
    icon: Image,
    borderColor: Color = .clear,
    borderWidth: CGFloat = 0,
    action: @escaping () -> Void,
    isEnabled: Binding<Bool> = .constant(true)
  ) {
    self.icon = icon
    self.borderColor = borderColor
    self.borderWidth = borderWidth
    self._isEnabled = isEnabled
    self.action = action
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
}

#Preview {
  VStack {
    ATRoundIconButton(icon: .init(systemName: "bolt"), action: {
      print("hola")
    })
  }
  
}
