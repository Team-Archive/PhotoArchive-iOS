//
//  ATSegmentedControlView.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 4/24/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI

public struct ATSegmentedControlView: View {
  
  // MARK: - public state
  
  @State private(set) var selectedSegmentIndex: Int = 0
  
  // MARK: - private properties
  
  @State private var segmentWidthList: [CGFloat]
  private let segmentTitleList: [String]
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  public var body: some View {
    GeometryReader { geometry in
      VStack {
        ZStack(alignment: .leading) {
          Capsule()
            .fill(UIComponentsAsset.Colors.white.swiftUIColor)
            .frame(width: self.segmentWidthList[self.selectedSegmentIndex], height: 36)
            .offset(x: self.xOffset(index: self.selectedSegmentIndex), y: 0)
            .animation(.easeInOut(duration: 0.3), value: selectedSegmentIndex)
          
          HStack(spacing: 0) {
            ForEach(0..<segmentTitleList.count, id: \.self) { index in
              ATSegmentedControlViewItemButton(title: segmentTitleList[index], index: index, selectedSegmentIndex: $selectedSegmentIndex, action: {
                withAnimation {
                  selectedSegmentIndex = index
                }
              })
              .background(
                GeometryReader { proxy in
                  Color.clear
                    .onAppear {
                      self.segmentWidthList[index] = proxy.size.width
                    }
                }
              )
            }
          }
        }
        .background(UIComponentsAsset.Colors.purpleGray200.swiftUIColor)
        .clipShape(Capsule())
      }
    }
    .frame(height: 36)
  }
  
  public init(
    segmentTitleList: [String]
  ) {
    self.segmentTitleList = segmentTitleList
    self.segmentWidthList = .init(repeating: 0, count: segmentTitleList.count)
  }
  
  // MARK: - private method
  
  private func xOffset(index: Int) -> CGFloat {
    guard index >= 0 && index < segmentWidthList.count else { return 0 }
    return segmentWidthList.prefix(index).reduce(0, +)
  }
  
  // MARK: - internal method
  
}

fileprivate struct ATSegmentedControlViewItemButton: View {
  
  // MARK: - public state
  
  let index: Int
  @Binding var selectedSegmentIndex: Int
  
  // MARK: - private properties
  
  private let title: String
  
  private var textColor: Color {
    if self.selectedSegmentIndex == self.index {
      return UIComponentsAsset.Colors.purpleGray300.swiftUIColor
    } else {
      return UIComponentsAsset.Colors.gray200.swiftUIColor
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
      HStack {
        Text(self.title)
          .font(self.font)
          .foregroundStyle(self.textColor)
          .padding(26)
      }
      .background(self.backgroundColor)
      .clipShape(.capsule)
    })
    .frame(height: 36)
    
  }
  
  public init(
    title: String,
    index: Int,
    selectedSegmentIndex: Binding<Int>,
    action: @escaping () -> Void
  ) {
    self.title = title
    self.index = index
    self._selectedSegmentIndex = selectedSegmentIndex
    self.action = action
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
}

#Preview {
  VStack {
    ATSegmentedControlView(segmentTitleList: ["Test11111111", "Test2"])
  }
}
