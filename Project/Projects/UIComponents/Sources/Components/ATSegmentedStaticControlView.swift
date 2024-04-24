//
//  ATSegmentedStaticControlView.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 4/24/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI

public struct ATSegmentedStaticControlView: View {
  
  public struct ATSegmentedStaticControlViewItem {
    let icon: Image
    let title: String
    
    public init(icon: Image, title: String) {
      self.icon = icon
      self.title = title
    }
  }
  
  // MARK: - public state
  
  @State private(set) var selectedSegmentIndex: Int = 0
  
  // MARK: - private properties
  
  private let segmentItemList: [ATSegmentedStaticControlViewItem]
  private let height: CGFloat
  private let underLineHeight: CGFloat = 2
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  public var body: some View {
    GeometryReader { geometry in
      VStack {
        ZStack(alignment: .init(horizontal: .leading, vertical: .top)) {
          Capsule()
            .fill(UIComponentsAsset.Colors.white.swiftUIColor)
            .frame(width: geometry.size.width / CGFloat(segmentItemList.count), height: self.underLineHeight)
            .offset(x: geometry.size.width / CGFloat(segmentItemList.count) * CGFloat(selectedSegmentIndex), y: self.height - self.underLineHeight)
            .animation(.easeInOut(duration: 0.3), value: selectedSegmentIndex)
          
          HStack(spacing: 0) {
            ForEach(0..<segmentItemList.count, id: \.self) { index in
              let item = segmentItemList[index]
              ATSegmentedStaticControlViewItemButton(
                title: item.title,
                icon: item.icon, 
                height: self.height,
                index: index,
                selectedSegmentIndex: $selectedSegmentIndex,
                action: {
                  withAnimation {
                    selectedSegmentIndex = index
                  }
                }
              )
              .frame(width: geometry.size.width / CGFloat(segmentItemList.count))
            }
          }
        }
        .background(.clear)
      }
    }
    .frame(height: self.height)
  }
  
  public init(
    segmentItemList: [ATSegmentedStaticControlViewItem],
    height: CGFloat = 48
  ) {
    self.segmentItemList = segmentItemList
    self.height = height
  }
  
  // MARK: - private method
  
  
  // MARK: - internal method
  
}

fileprivate struct ATSegmentedStaticControlViewItemButton: View {
  
  // MARK: - public state
  
  let index: Int
  @Binding var selectedSegmentIndex: Int
  
  // MARK: - private properties
  
  private let title: String
  private let icon: Image
  private let height: CGFloat
  
  private var textColor: Color {
    if self.selectedSegmentIndex == self.index {
      return UIComponentsAsset.Colors.white.swiftUIColor
    } else {
      return UIComponentsAsset.Colors.gray300.swiftUIColor
    }
  }
  
  private var backgroundColor: Color {
    return .clear
  }
  
  private var font: Font {
    if self.selectedSegmentIndex == self.index {
      return .fonts(.buttonExtraBold14)
    } else {
      return .fonts(.body14)
    }
  }
  
  
  // MARK: - public properties
  
  public var action: () -> Void
  
  // MARK: - life cycle
  
  public var body: some View {
    
    Button(action: {
      self.action()
    }, label: {
      HStack(spacing: 4) {
        self.icon
          .renderingMode(.template)
          .tint(self.textColor)
          .frame(width: 24, height: 24)
        Text(self.title)
          .font(self.font)
          .foregroundStyle(self.textColor)
      }
      .background(self.backgroundColor)
    })
    .frame(height: self.height)
    
  }
  
  public init(
    title: String,
    icon: Image,
    height: CGFloat,
    index: Int,
    selectedSegmentIndex: Binding<Int>,
    action: @escaping () -> Void
  ) {
    self.title = title
    self.icon = icon
    self.height = height
    self.index = index
    self._selectedSegmentIndex = selectedSegmentIndex
    self.action = action
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
}

#Preview {
  VStack {
    ATSegmentedStaticControlView(segmentItemList: [
      .init(icon: .init(systemName: "bolt"), title: "Bolt"),
      .init(icon: .init(systemName: "heart"), title: "Heart")
    ])
  }
}
