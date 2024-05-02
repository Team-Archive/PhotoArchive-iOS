//
//  ATTooltip.swift
//  UIComponents
//
//  Created by jinyoung on 4/29/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//
import SwiftUI

public struct ATTooltip: View {
  
  // MARK: - public state
  
  // MARK: - private properties
  
  // MARK: - public properties
  
  private let title: String
  
  private let contentColor: Color
  
  private let backgroundColor: Color
  
  // MARK: - life cycle
  
  public var body: some View {
    VStack {
      VStack {
        Spacer()
        HStack(spacing: 4) {
          Spacer().frame(width: 16)
          
          Text(title)
            .font(.fonts(.bodyBold14))
            .foregroundStyle(contentColor)
          
          Gen.Images.close.swiftUIImage
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .foregroundStyle(contentColor)
            .frame(width: 20)
          
          Spacer().frame(width: 16)
        }
        Spacer()
      }
      .background(backgroundColor)
      .clipShape(.rect(cornerRadius: 20))
      
      Gen.Images.tooltipArrow.swiftUIImage
        .resizable()
        .renderingMode(.template)
        .foregroundStyle(backgroundColor)
        .frame(width: 12, height: 10)

    }.frame(height: 50)
  }
  
  public init(
    title: String,
    contentColor: Color = Gen.Colors.purpleGray400.swiftUIColor,
    backgroundColor: Color = Gen.Colors.white.swiftUIColor
  ) {
    self.title = title
    self.contentColor = contentColor
    self.backgroundColor = backgroundColor
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
}

#Preview {
  VStack {
    ATTooltip(title: "Be the first to share the news!")
  }
  
}
