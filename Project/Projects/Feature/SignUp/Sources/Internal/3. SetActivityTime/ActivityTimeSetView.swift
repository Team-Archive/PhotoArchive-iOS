//
//  ActivityTimeSetView.swift
//  SignUp
//
//  Created by Aaron Hanwe LEE on 6/7/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import ArchiveFoundation

public struct ActivityTimeSetView: View {
  
  // MARK: - public state
  
  // MARK: - private properties
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  public var body: some View {
    VStack(spacing: 16) {
      TimeView()
      DaysOfTheWeekView()
    }
  }
  
  // MARK: - private method
  
  @ViewBuilder
  private func TimeView() -> some View {
    HStack {
      Checkbox
    }
  }
  
  @ViewBuilder
  private func DaysOfTheWeekView() -> some View {
    HStack {
      
    }
  }
  
  // MARK: - internal method
  
}

#Preview {
  VStack {
    
  }
}
