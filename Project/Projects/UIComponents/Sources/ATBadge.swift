//
//  ATBadge.swift
//  UIComponents
//
//  Created by jinyoung on 5/3/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//
import SwiftUI

public struct ATBadge: View {
  
  // MARK: - public state
  
  // MARK: - private properties
  private let text: String
  private let backgroundColor: Color
  private let contentColor: Color
  
  // MARK: - public properties
  
  
  
  // MARK: - life cycle
  
  public var body: some View {
    ZStack {
      Circle()
        .fill(backgroundColor)
        .frame(width: 24, height: 24)
      
      Text(text)
        .font(.fonts(.body14))
        .foregroundStyle(contentColor)
    }
  }
  
  public init(
    text: String,
    backgroundColor: Color = Gen.Colors.purple.swiftUIColor,
    contentColor: Color = Gen.Colors.white.swiftUIColor
  ) {
    self.text = text
    self.backgroundColor = backgroundColor
    self.contentColor = contentColor
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
}

#Preview {
  VStack {
    ATBadge(text: "1")
  }
  
}
