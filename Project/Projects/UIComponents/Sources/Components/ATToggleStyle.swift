//
//  ATToggleStyle.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 4/23/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI

public struct ATToggleStyle: ToggleStyle {
  
  var onColor: Color
  var offColor: Color
  var onThumbColor: Color
  var offThumbColor: Color
  
  public init(onColor: Color, offColor: Color, onThumbColor: Color, offThumbColor: Color) {
    self.onColor = onColor
    self.offColor = offColor
    self.onThumbColor = onThumbColor
    self.offThumbColor = offThumbColor
  }
  
  public func makeBody(configuration: Self.Configuration) -> some View {
    HStack {
      configuration.label
        .font(.body)
      Spacer()
      RoundedRectangle(cornerRadius: 16, style: .circular)
        .fill(configuration.isOn ? onColor : offColor)
        .frame(width: 46, height: 26)
        .overlay(
          Circle()
            .fill(configuration.isOn ? onThumbColor : offThumbColor)
            .padding(2)
            .offset(x: configuration.isOn ? 10 : -10)
        )
        .onTapGesture {
          withAnimation(.smooth(duration: 0.2)) {
            configuration.isOn.toggle()
          }
        }
    }
  }
  
}
