//
//  ATSelectableButton.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 4/25/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import Combine

public struct ATSelectableButton<Content>: View where Content: View {
  
  // MARK: - public state
  
  @Binding var isEnabled: Bool
  @State var isSelected: Bool
  
  // MARK: - private properties
  
  private let selectedBorderColor: Color
  private let selectedBorderWidth: CGFloat = 1
  private let defaultBackgroundColor: Color
  private let selectedBackgroundColor: Color
  private let font: Font = .fonts(.body13)
  private let textColor: Color = Gen.Colors.white.color
  private let contentsView: Content
  
  private var overlayBackgroundColor: Color {
    if self.isSelected {
      return self.selectedBackgroundColor
    } else {
      return .clear
    }
  }
  
  private var borderColor: Color {
    if self.isSelected {
      return self.selectedBorderColor
    } else {
      return .clear
    }
  }
  
  // MARK: - public properties
  
  public var action: (_ isSelected: Bool) -> Void
  
  // MARK: - life cycle
  
  public var body: some View {
    
    Button(action: {
      self.isSelected.toggle()
      self.action(self.isSelected)
    }, label: {
      ZStack {
        contentsView
          .padding([.top, .bottom], 8)
          .padding([.leading, .trailing], 10)
          .background(self.overlayBackgroundColor)
          .clipShape(.capsule)
      }
      .background(self.defaultBackgroundColor)
      .clipShape(.capsule)
      .overlay(
        Capsule()
          .stroke(self.borderColor, lineWidth: self.selectedBorderWidth)
      )
      
    })
    .disabled(!self.isEnabled)

  }
  
  public init(
    contentsView: Content,
    backgroundColor: Color = Gen.Colors.purpleGray200.color,
    selectedBackgroundColor: Color = Gen.Colors.purple.color.opacity(0.3),
    selectedBorderColor: Color = Gen.Colors.purple.color,
    isSelected: Bool = false,
    action: @escaping (_ isSelected: Bool) -> Void,
    isEnabled: Binding<Bool> = .constant(true)
  ) {
    self.contentsView = contentsView
    self.isSelected = isSelected
    self.selectedBorderColor = selectedBorderColor
    self.selectedBackgroundColor = selectedBackgroundColor
    self.defaultBackgroundColor = backgroundColor
    self._isEnabled = isEnabled
    self.action = action
  }
  
  
  // MARK: - private method
  
  // MARK: - internal method
  
}

#Preview {
  
  VStack {
    ATSelectableButton(contentsView: Text("hola"), action: { isSelected in
      print("Button: \(isSelected)")
    })
  }
  
}
