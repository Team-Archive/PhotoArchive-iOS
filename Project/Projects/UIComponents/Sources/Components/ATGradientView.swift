//
//  ATGradientView.swift
//  UIComponents
//
//  Created by jinyoung on 5/2/24.
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
            Gen.Colors.gradationMainStart.color,
            Gen.Colors.gradationMainEnd.color
          ]
        )
      case .morning:
        return Gradient(
          colors: [
            Gen.Colors.gradationMorningStart.color,
            Gen.Colors.gradationMorningEnd.color
          ]
        )
      case .afternoon:
        return Gradient(
          colors: [
            Gen.Colors.gradationAfternoonStart.color,
            Gen.Colors.gradationAfternoonEnd.color
          ]
        )
      case .evening:
        return Gradient(
          colors: [
            Gen.Colors.gradationEveningStart.color,
            Gen.Colors.gradationEveningEnd.color
          ]
        )
      case .night:
        return Gradient(
          colors: [
            Gen.Colors.gradationNightStart.color,
            Gen.Colors.gradationNightEnd.color
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
