//
//  ATBackgroundView.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 5/14/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI

public struct ATBackgroundView: View {
  
  // MARK: - public state
  
  // MARK: - private properties
  
  private let startColor: Color
  private let endColor: Color
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  public var body: some View {
    
    LinearGradient(
      gradient: Gradient(
        colors: [
          Gen.Colors.backgroundStart.color,
          Gen.Colors.backgroundEnd.color
        ]
      ),
      startPoint: .top,
      endPoint: .bottom
    )
    
  }
  
  public init(
    startColor: Color = Gen.Colors.backgroundStart.color,
    endColor: Color = Gen.Colors.backgroundEnd.color
  ) {
    self.startColor = startColor
    self.endColor = endColor
  }
  
  // MARK: - internal method
  
}

#Preview {
  VStack {
    ATBackgroundView()
  }
  
}
