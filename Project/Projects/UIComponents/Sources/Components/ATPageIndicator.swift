//
//  ATPageIndicator.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 5/20/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import UIKit

//public struct PageIndicator: View {
//  
//  // MARK: - private properties
//  
//  private let itemSpacing: CGFloat = 16
//  private let indicatorHeight: CGFloat = 8
//  
//  private let selectedColor: Color = Gen.Colors.purple.color
//  private let unselectedColor: Color = Gen.Colors.white.color.opacity(0.4)
//  
//  // MARK: - internal properties
//  
//  private(set) var numberOfPages: Int
//  @Binding private(set) var currentPage: Int
//  
//  // MARK: - life cycle
//  
//  public init(numberOfPages: Int, currentPage: Binding<Int>) {
//    self.numberOfPages = numberOfPages
//    self._currentPage = currentPage
//  }
//  
//  public var body: some View {
//    GeometryReader { geometry in
//      ScrollViewReader { scrollViewProxy in
//        ScrollView(.horizontal, showsIndicators: false) {
//          HStack(spacing: itemSpacing) {
//            ForEach(0..<numberOfPages, id: \.self) { index in
//              Circle()
//                .fill(index == currentPage ? self.selectedColor : self.unselectedColor)
//                .frame(
//                  width: self.indicatorSize().width,
//                  height: self.indicatorSize().height
//                )
//                .id(index)
//                .onTapGesture {
//                  currentPage = index
//                }
//            }
//          }
//        }
//        .onChange(of: currentPage) {
//          centerCurrentPage(scrollViewProxy: scrollViewProxy, scrollViewWidth: geometry.size.width)
//        }
//      }
//    }
//    .frame(height: self.indicatorHeight)
//  }
//  
//  // MARK: - private method
//  
//  // MARK: - public method
//  
//  private func centerCurrentPage(scrollViewProxy: ScrollViewProxy, scrollViewWidth: CGFloat) {
//    withAnimation {
//      scrollViewProxy.scrollTo(currentPage, anchor: .center)
//    }
//  }
//  
//  private func indicatorSize() -> CGSize {
//    // TODO: 양쪽 원 사이즈 조절 만들기
//    return .init(width: self.indicatorHeight, height: self.indicatorHeight)
//  }
//}
public struct ATPageIndicator: UIViewRepresentable {
  var numberOfPages: Int
  @Binding var currentPage: Int
  
  public class Coordinator: NSObject {
    var parent: ATPageIndicator
    
    init(_ parent: ATPageIndicator) {
      self.parent = parent
    }
    
    @objc func updateCurrentPage(sender: UIPageControl) {
      parent.currentPage = sender.currentPage
    }
  }
  
  public func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  public func makeUIView(context: Context) -> UIPageControl {
    let control = UIPageControl()
    control.numberOfPages = numberOfPages
    control.currentPage = currentPage
    control.addTarget(context.coordinator, action: #selector(Coordinator.updateCurrentPage(sender:)), for: .valueChanged)
    return control
  }
  
  public func updateUIView(_ uiView: UIPageControl, context: Context) {
    uiView.numberOfPages = numberOfPages
    uiView.currentPage = currentPage
  }
  
  public init(numberOfPages: Int, currentPage: Binding<Int>) {
    self.numberOfPages = numberOfPages
    self._currentPage = currentPage
  }
}
