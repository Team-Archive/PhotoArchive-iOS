//
//  ATSelectableTextButton.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 6/7/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import ArchiveFoundation
import Combine

public struct ATSelectableTextButton: View {
  
  // MARK: - public state
  
  @Binding var isEnabled: Bool
  @Binding var isSelected: Bool
  
  // MARK: - private properties
  
  private let text: String
  
  // MARK: - public properties
  
  public var action: (_ isSelected: Bool) -> Void
  
  // MARK: - life cycle
  
  public var body: some View {
    
    ATSelectableButton(
      contentsView: ATSelectableTextContentsView(text: text),
      isSelected: $isSelected
    ) { isSelected in
      self.action(isSelected)
    }

  }
  
  public init(
    text: String,
    isSelected: Binding<Bool>,
    action: @escaping (_ isSelected: Bool) -> Void,
    isEnabled: Binding<Bool> = .constant(true)
  ) {
    self.text = text
    self._isSelected = isSelected
    self._isEnabled = isEnabled
    self.action = action
  }
  
  
  // MARK: - private method
  
  // MARK: - internal method
  
}

public struct ATSelectableTextContentsView: View {
  
  // MARK: - public state
  
  // MARK: - private properties
  
  private let text: String
  
  private let font: Font = .fonts(.body13)
  private let textColor: Color = Gen.Colors.white.color
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  public var body: some View {
    
    HStack(spacing: 1.5) {
      Text(text)
        .font(self.font)
        .foregroundStyle(textColor)
    }
    
  }
  
  public init(
    text: String
  ) {
    self.text = text
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
}

#Preview {
  
  VStack {
    ATSelectableTextButton(text: "hola", isSelected: .constant(false)) { isSelected in
      print("hola: \(isSelected)")
    }
  }
  
}
