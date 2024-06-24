//
//  ViewExtension.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 6/4/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI

extension View {
  
  public func onDebouncedChange(of value: String, debounceTime: TimeInterval, perform: @escaping (String) -> Void) -> some View {
    modifier(DebouncedChangeModifier(value: value, debounceTime: debounceTime, perform: perform))
  }
  
}
