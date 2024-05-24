//
//  WarningEffect.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 5/17/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI

public struct WarningEffect: GeometryEffect {
  
  public var animatableData: CGFloat
  var amount: CGFloat = 3
  var shakeCount = 6
  
  public init(_ interval: CGFloat) {
    self.animatableData = interval
  }
  
  public func effectValue(size: CGSize) -> ProjectionTransform {
    ProjectionTransform(CGAffineTransform(translationX: amount * sin(animatableData * CGFloat(shakeCount) * .pi), y: 0))
  }
}

