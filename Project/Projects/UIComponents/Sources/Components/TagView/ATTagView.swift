//
//  ATTagView.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 4/23/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI

public struct ATTagView: View {
  
  public enum DesignType {
    case primary
    case secondary
  }
  
  // MARK: - public state
  
  // MARK: - private properties
  
  private let designType: DesignType
  private let title: String
  private let icon: Image?
  
  private var textColor: Color {
    switch self.designType {
    case .primary:
      return UIComponentsAsset.Colors.white.swiftUIColor
    case .secondary:
      return UIComponentsAsset.Colors.white.swiftUIColor
    }
  }
  
  private var backgroundColor: Color {
    switch self.designType {
    case .primary:
      return UIComponentsAsset.Colors.purpleGray300.swiftUIColor
    case .secondary:
      return UIComponentsAsset.Colors.gray200.swiftUIColor
    }
  }
  
  private var font: Font {
    switch self.designType {
    case .primary:
      return .fonts(.body13)
    case .secondary:
      return .fonts(.body13)
    }
  }
  
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  public var body: some View {
    
    HStack(spacing: 1) {
      if let icon {
        icon
          .foregroundStyle(textColor)
          .padding(.leading, 5.5)
      }
      Text(title)
        .font(font)
        .foregroundStyle(textColor)
        .padding(.trailing, 5.5)
        .padding(.leading, icon == nil ? 5.5 : 0)
    }
    .frame(height: 20)
    .background(self.backgroundColor)
    .clipShape(.rect(cornerRadius: 10))
    
  }
  
  public init(
    designType: DesignType = .primary,
    icon: Image?,
    title: String
  ) {
    self.designType = designType
    self.icon = icon
    self.title = title
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
}

#Preview {
  VStack {
    ATTagView(icon: Image(systemName: "bolt"), title: "hola")
  }
  
}
