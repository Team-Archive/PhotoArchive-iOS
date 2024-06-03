//
//  Button.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 6/3/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI

extension Button {
  
  public static func throttledAction(throttleTime: TimeInterval, action: @escaping () -> Void, @ViewBuilder label: @escaping () -> Label) -> some View {
    ThrottledButton(action: action, throttleTime: throttleTime, label: label)
  }
  
  public static func debouncedAction(debounceTime: TimeInterval, action: @escaping () -> Void, @ViewBuilder label: @escaping () -> Label) -> some View {
    DebouncedButton(action: action, debounceTime: debounceTime, label: label)
  }
  
}
