//
//  ATPageIndicator.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 5/20/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import UIKit

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
    control.currentPageIndicatorTintColor = Gen.Colors.purple.uikitColor
    control.pageIndicatorTintColor = Gen.Colors.white.uikitColor.withAlphaComponent(0.4)
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
