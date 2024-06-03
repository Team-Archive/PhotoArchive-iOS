//
//  ATStepProgressView.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 6/3/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI

public struct ATStepProgressView: View {
  
  // MARK: - public state
  
  // MARK: - private properties
  
  private let totalStep: UInt
  @Binding private var currentStep: UInt
  private let itemInset: CGFloat = 4
  private let defaultColor: Color = Gen.Colors.gray200.color
  private let highlightColor: Color = Gen.Colors.white.color
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  public init(
    totalStep: UInt,
    currentStep: Binding<UInt>
  ) {
    self.totalStep = totalStep
    self._currentStep = currentStep
  }
  
  public var body: some View {
    GeometryReader { geometry in
      HStack(spacing: self.itemInset) {
        ForEach(0..<totalStep, id: \.self) { index in
          ZStack {
            Rectangle()
              .foregroundStyle(.gray)
              .frame(width: (geometry.size.width - (CGFloat(totalStep - 1) * itemInset)) / CGFloat(totalStep))
            Rectangle()
              .fill(index < self.currentStep ? highlightColor : defaultColor)
              .frame(width: (geometry.size.width - (CGFloat(totalStep - 1) * itemInset)) / CGFloat(totalStep))
              .scaleEffect(x: index < self.currentStep ? 1 : 0, anchor: .leading)
              .animation(.easeInOut(duration: 0.5), value: currentStep)
          }
        }
      }
    }
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
}
