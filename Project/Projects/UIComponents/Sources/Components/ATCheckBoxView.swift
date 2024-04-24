//
//  ATCheckBoxView.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 4/24/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI

public struct ATCheckBoxView: View {
  
  // MARK: - public state
  
  @State public var isChecked: Bool
  
  // MARK: - private properties
  
  private let title: String
  
  private var textColor: Color {
    return UIComponentsAsset.Colors.white.swiftUIColor
  }
  
  private var iconColor: Color {
    return UIComponentsAsset.Colors.white.swiftUIColor
  }
  
  private var backgroundColor: Color {
    if self.isChecked {
      return UIComponentsAsset.Colors.purple.swiftUIColor
    } else {
      return UIComponentsAsset.Colors.white.swiftUIColor.opacity(0.8)
    }
  }
  
  private var borderColor: Color {
    if self.isChecked {
      return .clear
    } else {
      return UIComponentsAsset.Colors.gray300.swiftUIColor
    }
  }
  
  private var font: Font {
    return .fonts(.body14)
  }
  
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  public var body: some View {
    
    Button(action: {
      self.isChecked = !self.isChecked
    }, label: {
      HStack(spacing: 4) {
        ZStack {
          Circle()
            .tint(self.backgroundColor)
          UIComponentsAsset.Images.check.swiftUIImage
            .resizable()
            .renderingMode(.template)
            .tint(UIComponentsAsset.Colors.white.swiftUIColor)
            .aspectRatio(contentMode: .fill)
            .frame(width: 12, height: 12, alignment: .center)
        }.overlay(
          Circle()
            .stroke(self.borderColor, lineWidth: 1)
            .opacity(1)
        )
        .frame(width: 24, height: 24)
        Text(self.title)
          .font(self.font)
          .foregroundStyle(self.textColor)
      }
    })

  }
  
  public init(
    title: String,
    isChecked: Bool
  ) {
    self.title = title
    self.isChecked = isChecked
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
}

#Preview {
  VStack {
    ATCheckBoxView(title: "hola", isChecked: false)
  }
}
