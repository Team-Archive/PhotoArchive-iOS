//
//  ThrottledButton.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 6/3/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI

struct ThrottledButton<Label: View>: View {
  let action: () -> Void
  let throttleTime: TimeInterval
  let label: Label
  @State private var isThrottled = false
  
  init(action: @escaping () -> Void, throttleTime: TimeInterval, @ViewBuilder label: () -> Label) {
    self.action = action
    self.throttleTime = throttleTime
    self.label = label()
  }
  
  var body: some View {
    Button(action: {
      if !isThrottled {
        isThrottled = true
        action()
        DispatchQueue.main.asyncAfter(deadline: .now() + throttleTime) {
          isThrottled = false
        }
      }
    }) {
      label
    }
  }
}
