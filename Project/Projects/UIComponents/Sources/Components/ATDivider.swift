//
//  ATDivider.swift
//  UIComponents
//
//  Created by 김진영 on 5/7/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//
import SwiftUI

public struct ATDivider: View {
  
  // MARK: - public state
  public enum ATDividerType {
    case small
    case medium
    case large
    
    var height: CGFloat {
      switch self {
      case .small:
        return 2
      case .medium:
        return 4
      case .large:
        return 8
      }
    }
  }
  
  // MARK: - private properties
  private let type: ATDividerType
  
  // MARK: - public properties
  
  
  // MARK: - life cycle
  
  public var body: some View {
    Gen.Colors.black.color
      .frame(height: type.height)
  }
  
  public init(type: ATDividerType) {
    self.type = type
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
}

#Preview {
  VStack {
    ATDivider(type: .small)
  }
  
}
