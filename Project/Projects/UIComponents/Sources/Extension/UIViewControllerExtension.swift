//
//  UIViewControllerExtension.swift
//  UIComponents
//
//  Created by hanwe on 10/27/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import UIKit
import Foundation

extension UIViewController {
  public static var topViewController: UIViewController? {
    guard let rootViewController = UIApplication.shared.connectedScenes
      .compactMap({ ($0 as? UIWindowScene)?.keyWindow?.rootViewController })
      .first else {
      return nil
    }
    return findTopViewController(viewController: rootViewController)
  }
  
  private static func findTopViewController(viewController: UIViewController) -> UIViewController? {
    if let presentedViewController = viewController.presentedViewController {
      return findTopViewController(viewController: presentedViewController)
    }
    
    if let navigationController = viewController as? UINavigationController,
       let visibleViewController = navigationController.visibleViewController {
      return findTopViewController(viewController: visibleViewController)
    }
    
    if let tabBarController = viewController as? UITabBarController,
       let selectedViewController = tabBarController.selectedViewController {
      return findTopViewController(viewController: selectedViewController)
    }
    
    return viewController
  }
}
