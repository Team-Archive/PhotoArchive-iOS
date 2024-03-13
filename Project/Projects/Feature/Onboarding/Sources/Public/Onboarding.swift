//
//  Onboarding.swift
//  Onboarding
//
//  Created by Aaron Hanwe LEE on 1/29/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import ArchiveFoundation
import Domain

public struct OnboardingView: View {
  public var body: some View {
    VStack {
      Text("Hello, world!")
    }
    .padding()
    .onAppear {
//      signUpTest.signUp()
    }
  }
  
  public init() {
    
  }
  
}

#Preview {
  OnboardingView()
}
