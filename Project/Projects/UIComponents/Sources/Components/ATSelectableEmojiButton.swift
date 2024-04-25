//
//  ATSelectableEmojiButton.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 4/25/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import ArchiveFoundation
import Combine

public struct ATSelectableEmojiButton: View {
  
  // MARK: - public state
  
  @Binding var isEnabled: Bool
  @State var isSelected: Bool
  
  // MARK: - private properties
  
  @State var selectedCount: UInt
  private let emoji: ExpressiveEmoji
  
  // MARK: - public properties
  
  public var action: (_ isSelected: Bool) -> Void
  
  // MARK: - life cycle
  
  public var body: some View {
    
    ATSelectableButton(
      contentsView: ATSelectableEmojiContentsView(
        emoji: self.emoji,
        count: self.$selectedCount
      ), 
      isSelected: true
    ) { isSelected in
      if isSelected {
        selectedCount += 1
      } else {
        if selectedCount != 0 {
          selectedCount -= 1
        }
      }
      self.action(isSelected)
    }

  }
  
  public init(
    emoji: ExpressiveEmoji,
    selectedCount: UInt,
    isSelected: Bool = false,
    action: @escaping (_ isSelected: Bool) -> Void,
    isEnabled: Binding<Bool> = .constant(true)
  ) {
    self.emoji = emoji
    self.selectedCount = selectedCount
    self.isSelected = isSelected
    self._isEnabled = isEnabled
    self.action = action
  }
  
  
  // MARK: - private method
  
  // MARK: - internal method
  
}

public struct ATSelectableEmojiContentsView: View {
  
  // MARK: - public state
  
  // MARK: - private properties
  
  @Binding private var count: UInt
  private let emoji: ExpressiveEmoji
  
  private let font: Font = .fonts(.body13)
  private let textColor: Color = UIComponentsAsset.Colors.white.swiftUIColor
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  public var body: some View {
    
    HStack(spacing: 1.5) {
      Text("\(emoji.emoji)")
        .font(self.font)
      Text("\(count)")
        .font(self.font)
        .foregroundStyle(textColor)
    }
    
  }
  
  public init(
    emoji: ExpressiveEmoji,
    count: Binding<UInt>
  ) {
    self.emoji = emoji
    self._count = count
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
}

#Preview {
  
  VStack {
    ATSelectableEmojiButton(emoji: .flower, selectedCount: 10) { isSelected in
      print("hola: \(isSelected)")
    }
  }
  
}
