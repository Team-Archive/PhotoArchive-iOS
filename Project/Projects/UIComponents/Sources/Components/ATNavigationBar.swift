//
//  ATNavigationBar.swift
//  UIComponents
//
//  Created by jinyoung on 5/7/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI

public struct ATNavigationBar: View {
  public enum ATNavigationBarType {
    case `default`(title: String = "", trailingIcon: Image? = nil)
  }
  
  // MARK: - public state
  
  // MARK: - private properties
  private let type: ATNavigationBarType
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  public var body: some View {
    HStack {
      switch type {
      case .default(let title, let trailingIcon):
        Gen.Images.back.image
          .resizable()
          .frame(width: 24, height: 24)
        
        Spacer()
        
        Text(title)
          .font(.fonts(.bodyBold16))
          .foregroundStyle(Gen.Colors.white.color)
        
        Spacer()
        
        trailingIcon?
          .resizable()
          .frame(width: 24, height: 24)
      }
    }
    .padding(.horizontal, 18)
    .padding(.vertical, 16)
    .frame(height: 56)
  }
  
  public init(type: ATNavigationBarType) {
    self.type = type
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
}

#Preview {
  VStack {
    ATNavigationBar(type: .default(title: "", trailingIcon: Gen.Images.refresh24.image))
  }
  
}
