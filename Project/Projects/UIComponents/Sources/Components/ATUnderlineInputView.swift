//
//  ATUnderlineInputView.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 6/3/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI

public struct ATUnderlineInputView: View {
  
  // MARK: - public state
  
  // MARK: - private properties
  
  private let maxLength: Int
  private let placeholderMessage: String
  private let submitLabel: SubmitLabel
  private let leftIconImage: Image?
  private let defaultUnderlineColor: Color = Gen.Colors.white.color
  private let warningUnderlineColor: Color = Gen.Colors.red.color
  
  @Binding private var message: String
  @Binding private var isValidMessage: Bool
  @FocusState private var isActivated: Bool
  @State private var isOverTextLength: Bool = false
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  
  public var body: some View {
    VStack(spacing: 12) {
      HStack(spacing: 4) {
        if let leftIconImage {
          leftIconImage
            .renderingMode(.template)
            .foregroundStyle(Gen.Colors.gray300.color)
        }
        ZStack {
          if message.isEmpty {
            HStack {
              Text(self.placeholderMessage)
                .foregroundColor(Gen.Colors.purpleGray100.color)
                .font(.fonts(.body14))
              Spacer()
            }
          }
          TextField("", text: $message)
            .focused($isActivated)
            .onChange(of: message, { oldValue, newValue in
              self.isOverTextLength = newValue.count > self.maxLength
            })
            .font(.fonts(.body14))
            .foregroundStyle(Gen.Colors.white.color)
            .submitLabel(self.submitLabel)
        }
        .frame(height: 24)
        
        Button(action: {
          message = ""
        }) {
          Gen.Images.xCircle.image
            .opacity(message.isEmpty ? 0 : 1)
            .animation(.easeInOut(duration: 0.15), value: message.isEmpty)
        }
        .frame(width: 24, height: 24)
      }
      Rectangle()
        .foregroundStyle(self.isOverTextLength || !self.isValidMessage ? self.warningUnderlineColor : self.defaultUnderlineColor)
        .frame(height: 1)
    }
  }

  public init(
    leftIconImage: Image? = nil,
    placeholderMessage: String,
    message: Binding<String>,
    isValidMessage: Binding<Bool>,
    submitLabel: SubmitLabel = .done,
    maxLength: Int = .max
  ) {
    self.leftIconImage = leftIconImage
    self.placeholderMessage = placeholderMessage
    self._message = message
    self._isValidMessage = isValidMessage
    self.submitLabel = submitLabel
    self.maxLength = maxLength
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
}

#Preview {
  VStack {
    
  }
  
}
