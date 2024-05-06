//
//  ATToast.swift
//  UIComponents
//
//  Created by jinyoung on 5/3/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI

public struct ATToast: View {
  
  public enum ATToastIcon {
    case check
    
    var image: Image {
      switch self {
      case .check:
        return Gen.Images.check.image
      }
    }
    
    var tintColor: Color {
      switch self {
      case .check:
        return Gen.Colors.green.color
      }
    }
  }
  
  // MARK: - public state
  
  // MARK: - private properties
  private let icon: ATToastIcon
  private let message: String
  
  // MARK: - public properties
  
  
  
  // MARK: - life cycle
  
  public var body: some View {
    VStack {
      HStack(spacing: 10) {
        icon.image
          .resizable()
          .renderingMode(.template)
          .foregroundStyle(icon.tintColor)
          .frame(width: 24, height: 24)
        
        Text(message)
          .font(.fonts(.buttonSemiBold14))
          .foregroundStyle(Gen.Colors.white.color)
        
        Spacer()
        
        Gen.Images.closeMini.image
          .resizable()
          .renderingMode(.template)
          .frame(width: 24, height: 24)
          .foregroundStyle(Gen.Colors.white.color)
      }
      .padding(.horizontal, 16)
    }
    .padding(.vertical, 14)
    .background(Gen.Colors.purpleGray300.color)
    .clipShape(.rect(cornerRadius: 8))
    .padding()
  }
  
  public init(icon: ATToastIcon, message: String) {
    self.icon = icon
    self.message = message
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
}

#Preview {
  VStack {
    ATToast(icon: .check, message: "사진 업로드가 완료되었습니다.")
  }
  
}
