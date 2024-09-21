//
//  EmojiListView.swift
//  MyProfile
//
//  Created by jinyoung on 9/8/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import ArchiveFoundation
import UIComponents

public struct EmojiListView: View {
  
  // MARK: - public state
  
  // MARK: - private properties
  private let dataSource: [EmojiListModel] = [
    EmojiListModel(emoji: .heart, count: 10),
    EmojiListModel(emoji: .flower, count: 1),
  ]
  
  // MARK: - public properties
  
  
  
  // MARK: - life cycle
  
  public var body: some View {
//    리듀서 붙여야 할듯..?
//    범위는 이미지 리스트랑, 이모지 반응 리스트
//    딱 포스팅 하나에 대한 데이터 정리할 수 있는거..
    let rows: [GridItem] = Array(repeating: .init(.flexible(), spacing: 0), count: 1)
    LazyHGrid(rows: rows) {
//      ForEach(0..<dataSource.count, id: \.self) { index in
//        guard let item = dataSource[safe: index] else { return }
//        ATSelectableEmojiButton(emoji: <#T##ExpressiveEmoji#>, selectedCount: <#T##UInt#>, isSelected: <#T##Binding<Bool>#>, action: <#T##(Bool, UInt) -> Void##(Bool, UInt) -> Void##(_ isSelected: Bool, _ count: UInt) -> Void#>, isEnabled: <#T##Binding<Bool>#>)
//      }
    }
  }
  
  public init() {
    
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
}

public struct EmojiListModel {
  public let emoji: ExpressiveEmoji
  public var count: UInt
}
