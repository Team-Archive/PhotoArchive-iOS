//
//  TextFieldModifier.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 6/4/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI

struct DebouncedChangeModifier: ViewModifier {
  let value: String
  let debounceTime: TimeInterval
  let perform: (String) -> Void
  
  @State private var debounceTimer: Timer?
  
  func body(content: Content) -> some View {
    content
      .onChange(of: value) { oldValue, newValue in
        debounceTimer?.invalidate()
        debounceTimer = Timer.scheduledTimer(withTimeInterval: debounceTime, repeats: false) { _ in
          perform(newValue)
        }
      }
  }
}
