//
//  OnboardingTermsView.swift
//  Onboarding
//
//  Created by Aaron Hanwe LEE on 6/12/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import UIComponents
import ArchiveFoundation
import ComposableArchitecture

struct OnboardingTermsView: View {
  
  // MARK: - internal state
  
  // MARK: - private properties
  
  private var completeAction: () -> Void
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  init(
    completeAction: @escaping () -> Void
  ) {
    self.completeAction = completeAction
  }
  
  var body: some View {
    ZStack {
      Button(action: {
        completeAction()
      }, label: {
        Text("모두 동의")
      })
    }
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
}
