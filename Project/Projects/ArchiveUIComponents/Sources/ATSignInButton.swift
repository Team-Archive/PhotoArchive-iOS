//
//  ATSignInButton.swift
//  ArchiveUIComponents
//
//  Created by Aaron Hanwe LEE on 3/13/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI

public struct ATSignInButton: View {
  
  // MARK: - public state
  
  // MARK: - private properties
  
  private let iconImage: Image
  private let contents: String
  private let textColor: Color
  private let textFont: Font
  private let backgroundColor: Color
  private let borderColor: Color?
  
  
  // MARK: - internal properties
  
  // MARK: - life cycle
  
  public var body: some View {
    HStack {
      iconImage
        .renderingMode(.original)
      Text(contents)
        .font(textFont)
      
    }
    .padding()
    .background(backgroundColor)
  }
  
  public init(
    iconImage: Image,
    contents: String,
    textColor: Color,
    textFont: Font,
    backgroundColor: Color,
    borderColor: Color? = nil
  ) {
    self.iconImage = iconImage
    self.contents = contents
    self.textColor = textColor
    self.textFont = textFont
    self.backgroundColor = backgroundColor
    self.borderColor = borderColor
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
}

#Preview {
  ATSignInButton(
    iconImage: Image(systemName: "bolt"),
    contents: "회원가입",
    textColor: .black, 
    textFont: .body,
    backgroundColor: .brown
  )
}
