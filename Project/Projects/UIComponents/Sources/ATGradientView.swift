//
//  ATGradientView.swift
//  UIComponents
//
//  Created by 김진영 on 5/2/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI

public struct ATGradientView: View {
  
  public enum ATGradientType {
    case main
    case morning
    case afternoon
    case evening
    case night
    
    var gradient: Gradient {
      switch self {
      case .main:
        return Gradient(
          colors: [
            Gen.Colors.gradationMainStart.swiftUIColor,
            Gen.Colors.gradationMainEnd.swiftUIColor
          ]
        )
      case .morning:
        return Gradient(
          colors: [
            Gen.Colors.gradationMorningStart.swiftUIColor,
            Gen.Colors.gradationMorningEnd.swiftUIColor
          ]
        )
      case .afternoon:
        return Gradient(
          colors: [
            Gen.Colors.gradationAfternoonStart.swiftUIColor,
            Gen.Colors.gradationAfternoonEnd.swiftUIColor
          ]
        )
      case .evening:
        return Gradient(
          colors: [
            Gen.Colors.gradationEveningStart.swiftUIColor,
            Gen.Colors.gradationEveningEnd.swiftUIColor
          ]
        )
      case .night:
        return Gradient(
          colors: [
            Gen.Colors.gradationNightStart.swiftUIColor,
            Gen.Colors.gradationNightEnd.swiftUIColor
          ]
        )
      }
    }
  }
  
  public enum ATGradientDirection {
    case horizontal
    case vertical
  }
  
  // MARK: - public state
  
  // MARK: - private properties
  private let type: ATGradientType
  private let direction: ATGradientDirection
  private let isReversed: Bool
  
  // MARK: - public properties
  public init(type: ATGradientType, direction: ATGradientDirection, isReversed: Bool = false) {
    self.type = type
    self.direction = direction
    self.isReversed = isReversed
  }

  
  // MARK: - life cycle
  
  public var body: some View {
    VStack {
      switch direction {
      case .horizontal:
        if isReversed {
          LinearGradient(gradient: type.gradient, startPoint: .trailing, endPoint: .leading)
        } else {
          LinearGradient(gradient: type.gradient, startPoint: .leading, endPoint: .trailing)
        }
      case .vertical:
        if isReversed {
          LinearGradient(gradient: type.gradient, startPoint: .bottom, endPoint: .top)
        } else {
          LinearGradient(gradient: type.gradient, startPoint: .top, endPoint: .bottom)
        }
      }
    }
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
}

#Preview {
  VStack {
    ATGradientView(type: .morning, direction: .vertical)
  }
}
