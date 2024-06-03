//
//  DebouncedButton.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 6/3/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI

struct DebouncedButton<Label: View>: View {
  let action: () -> Void
  let debounceTime: TimeInterval
  let label: Label
  @State private var debounceTimer: Timer?
  
  init(action: @escaping () -> Void, debounceTime: TimeInterval, @ViewBuilder label: () -> Label) {
    self.action = action
    self.debounceTime = debounceTime
    self.label = label()
  }
  
  var body: some View {
    Button(action: {
      debounceTimer?.invalidate()
      debounceTimer = Timer.scheduledTimer(withTimeInterval: debounceTime, repeats: false) { _ in
        action()
      }
    }) {
      label
    }
  }
}
