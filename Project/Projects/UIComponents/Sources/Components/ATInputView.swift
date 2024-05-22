//
//  ATInputView.swift
//  UIComponents
//
//  Created by jinyoung on 5/3/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI

public struct ATInputView: View {
  
  // MARK: - public state
  
  // MARK: - private properties
  
  private let maxLength: Int
  private let originPlaceholder: String
  private let submitLabel: SubmitLabel
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  @Binding var message: String
  @State var isMaxText: Color = .clear
  @State var placeholder: String
  @FocusState private var isActivated: Bool
  
  public var body: some View {
    VStack {
      HStack(spacing: 4) {
        if !isActivated, message.isEmpty {
          Gen.Images.text16.image
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .foregroundStyle(Gen.Colors.white.color)
            .frame(width: 16)
        }

        TextField(placeholder,
                  text: $message,
                  prompt: Text(placeholder).font(.fonts(.bodyBold14)).foregroundStyle(isActivated ? Gen.Colors.gray600.color : Gen.Colors.white.color))
        .focused($isActivated)
        .onChange(of: message, { oldValue, newValue in
          if newValue.count > maxLength + 1 {
            message = oldValue
          } else if newValue.count == .zero {
            placeholder = self.originPlaceholder
          } else {
            placeholder = ""
          }
        })
        .font(.fonts(.bodyBold14))
        .foregroundStyle(Gen.Colors.white.color)
        .fixedSize(horizontal: true, vertical: true)
        .submitLabel(self.submitLabel)
      }
      .padding(.vertical, 6)
      .padding(.horizontal, 12)
      .background(Gen.Colors.purpleGray400.color)
      .clipShape(.rect(cornerRadius: 20))
      .overlay(
        RoundedRectangle(cornerRadius: 20)
          .stroke(message.count > maxLength ? Gen.Colors.red
            .color: .clear)
      )
    }.padding()
  }

  public init(
    placeholder: String,
    message: Binding<String>,
    submitLabel: SubmitLabel = .done,
    _ maxLength: Int = 30
  ) {
    self.placeholder = placeholder
    self.originPlaceholder = placeholder
    self._message = message
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
