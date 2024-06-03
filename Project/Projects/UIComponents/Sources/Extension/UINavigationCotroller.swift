//
//  UINavigationCotroller.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 6/3/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import UIKit

extension UINavigationController: UIGestureRecognizerDelegate {
  override open func viewDidLoad() {
    super.viewDidLoad()
    interactivePopGestureRecognizer?.delegate = self
  }
  
  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return viewControllers.count > 1
  }
}
