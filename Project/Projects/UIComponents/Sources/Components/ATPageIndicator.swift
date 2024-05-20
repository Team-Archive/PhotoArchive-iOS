//
//  ATPageIndicator.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 5/20/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI

public struct PageIndicator: View {
  
  // MARK: - private properties
  
  private let itemSpacing: CGFloat = 16
  private let indicatorHeight: CGFloat = 40
  
  private let selectedColor: Color = Gen.Colors.purple.color
  private let unselectedColor: Color = Gen.Colors.white.color.opacity(0.4)
  
  // MARK: - internal properties
  
  private(set) var numberOfPages: Int
  @Binding private(set) var currentPage: Int
  
  // MARK: - life cycle
  
  public init(numberOfPages: Int, currentPage: Binding<Int>) {
    self.numberOfPages = numberOfPages
    self._currentPage = currentPage
  }
  
  public var body: some View {
    GeometryReader { geometry in
      ScrollViewReader { scrollViewProxy in
        ScrollView(.horizontal, showsIndicators: false) {
          HStack(spacing: itemSpacing) {
            ForEach(0..<numberOfPages, id: \.self) { index in
              Circle()
                .fill(index == currentPage ? self.selectedColor : self.unselectedColor)
                .frame(
                  width: self.indicatorSize().width,
                  height: self.indicatorSize().height
                )
                .id(index)
                .onTapGesture {
                  currentPage = index
                }
            }
          }
        }
        .onChange(of: currentPage) {
          centerCurrentPage(scrollViewProxy: scrollViewProxy, scrollViewWidth: geometry.size.width)
        }
      }
    }
    .frame(height: self.indicatorHeight)
  }
  
  // MARK: - private method
  
  // MARK: - public method
  
  private func centerCurrentPage(scrollViewProxy: ScrollViewProxy, scrollViewWidth: CGFloat) {
    withAnimation {
      scrollViewProxy.scrollTo(currentPage, anchor: .center)
    }
  }
  
  private func indicatorSize() -> CGSize {
    // TODO: 양쪽 원 사이즈 조절 만들기
    return .init(width: 8, height: 8)
  }
}
