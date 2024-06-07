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
  
  @Binding public var isChecked: Bool
  
  // MARK: - private properties
  
  private let title: String?
  
  private var textColor: Color {
    return Gen.Colors.white.color
  }
  
  private var iconColor: Color {
    return Gen.Colors.white.color
  }
  
  private var backgroundColor: Color {
    if self.isChecked {
      return Gen.Colors.purple.color
    } else {
      return Gen.Colors.white.color.opacity(0.8)
    }
  }
  
  private var borderColor: Color {
    if self.isChecked {
      return .clear
    } else {
      return Gen.Colors.gray300.color
    }
  }
  
  private var font: Font {
    return .fonts(.body14)
  }
  
  
  // MARK: - public properties
  
  public var action: (_ isChecked: Bool) -> Void
  
  // MARK: - life cycle
  
  public var body: some View {
    
    Button(action: {
      self.action(self.isChecked)
    }, label: {
      HStack(spacing: 4) {
        ZStack {
          Circle()
            .tint(self.backgroundColor)
          Gen.Images.check.image
            .resizable()
            .renderingMode(.template)
            .tint(Gen.Colors.white.color)
            .aspectRatio(contentMode: .fill)
            .frame(width: 12, height: 12, alignment: .center)
        }.overlay(
          Circle()
            .stroke(self.borderColor, lineWidth: 1)
            .opacity(1)
        )
        .frame(width: 24, height: 24)
        if let title = self.title {
          Text(title)
            .font(self.font)
            .foregroundStyle(self.textColor)
        }
      }
    })
    
  }
  
  public init(
    title: String?,
    isChecked: Binding<Bool>,
    action: @escaping (_ isChecked: Bool) -> Void
  ) {
    self.title = title
    self._isChecked = isChecked
    self.action = action
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
}

#Preview {
  VStack {
    ATCheckBoxView(title: "hola", isChecked: .constant(false), action: { isChecked in
      print("isChecked: \(isChecked)")
    })
  }
}
