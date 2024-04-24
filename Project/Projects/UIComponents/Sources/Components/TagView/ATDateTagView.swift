//
//  ATDateTagView.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 4/24/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI

public struct ATDateTagView: View {
  
  
  // MARK: - public state
  
  // MARK: - private properties
  
  private let designType: ATTagView.DesignType
  private let date: Date
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  public var body: some View {
    
    ATTagView(
      designType: self.designType,
      icon: nil,
      title: "\(self.dateToString(self.date))"
    )
    
  }
  
  public init(
    designType: ATTagView.DesignType = .primary,
    date: Date
  ) {
    self.designType = designType
    self.date = date
  }
  
  // MARK: - private method
  
  private func dateToString(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "h:mm a"
    return formatter.string(from: date)
  }
  
  // MARK: - internal method
  
}

#Preview {
  VStack {
    ATDateTagView(date: Date())
  }
  
}
