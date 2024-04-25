//
//  ATRoundIconButton.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 4/23/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI

public struct ATRoundIconButton: View {
  
  public enum IconSizeType {
    case auto
    case constant(CGSize)
  }
  
  // MARK: - public state
  
  @Binding var isEnabled: Bool
  
  // MARK: - private properties
  
  private let icon: Image
  private let borderColor: Color
  private let borderWidth: CGFloat
  private let backgroundStartColorValue: Color
  private let backgroundEndColorValue: Color
  private let iconSizeType: IconSizeType
  
  private var backgroundStartColor: Color {
    if self.isEnabled {
      return self.backgroundStartColorValue
    } else {
      return UIComponentsAsset.Colors.purpleGray400.swiftUIColor
    }
  }
  
  private var backgroundEndColor: Color {
    if self.isEnabled {
      return self.backgroundEndColorValue
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
  
  @State private var height: CGFloat = 0
  
  var iconSize: CGSize {
    switch self.iconSizeType {
    case .auto:
      return .init(width: self.height * 0.545, height: self.height * 0.545)
    case .constant(let size):
      return size
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
          .resizable()
          .renderingMode(.template)
          .tint(self.iconColor)
          .frame(width: self.iconSize.width, height: self.iconSize.height)
      }
      .clipShape(.capsule)
      .overlay(
        Capsule()
          .stroke(self.borderColor, lineWidth: self.borderWidth)
          .opacity(0.5)
      )
      .background(
        GeometryReader { proxy in
          Color.clear
            .onAppear {
              self.height = proxy.size.height
            }
        }
      )
    })
    .disabled(!self.isEnabled)

  }
  
  public init(
    icon: Image,
    backgroundStartColor: Color = UIComponentsAsset.Colors.gradationMainStart.swiftUIColor,
    backgroundEndColor: Color = UIComponentsAsset.Colors.gradationMainEnd.swiftUIColor,
    borderColor: Color = .clear,
    borderWidth: CGFloat = 0,
    iconSizeType: IconSizeType = .auto,
    action: @escaping () -> Void,
    isEnabled: Binding<Bool> = .constant(true)
  ) {
    self.icon = icon
    self.backgroundStartColorValue = backgroundStartColor
    self.backgroundEndColorValue = backgroundEndColor
    self.borderColor = borderColor
    self.borderWidth = borderWidth
    self.iconSizeType = iconSizeType
    self._isEnabled = isEnabled
    self.action = action
  }
  
  public init(
    icon: Image,
    backgroundColor: Color,
    borderColor: Color = .clear,
    borderWidth: CGFloat = 0,
    iconSizeType: IconSizeType = .auto,
    action: @escaping () -> Void,
    isEnabled: Binding<Bool> = .constant(true)
  ) {
    self.init(
      icon: icon,
      backgroundStartColor: backgroundColor,
      backgroundEndColor: backgroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      iconSizeType: iconSizeType,
      action: action,
      isEnabled: isEnabled
    )
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
