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
  private let title: String
  private let contentColor: Color
  private let backgroundColor: Color
  
  @State private var isHidden = false
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  public var body: some View {
    if !isHidden {
    VStack(spacing: 0) {
        VStack {
          HStack(spacing: 4) {
            Text(title)
              .font(.fonts(.bodyBold14))
              .foregroundStyle(contentColor)
            
            Gen.Images.close.image
              .resizable()
              .renderingMode(.template)
              .aspectRatio(contentMode: .fit)
              .foregroundStyle(contentColor)
              .frame(width: 20)
              .onTapGesture {
                withAnimation {
                  isHidden = true
                }
              }
          }
          .padding(.horizontal, 16)
          .padding(.vertical, 10)
          
        }
        .background(backgroundColor)
        .clipShape(.rect(cornerRadius: 20))
        .frame(height: 40)
        
        Gen.Images.tooltipArrow.image
          .resizable()
          .renderingMode(.template)
          .foregroundStyle(backgroundColor)
          .frame(width: 12, height: 10)
      }
    } else {
      VStack {}
    }
  }
  
  public init(
    title: String,
    contentColor: Color = Gen.Colors.purpleGray400.color,
    backgroundColor: Color = Gen.Colors.white.color
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
