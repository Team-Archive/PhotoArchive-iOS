//
//  Onboarding.swift
//  Onboarding
//
//  Created by Aaron Hanwe LEE on 1/29/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import ArchiveFoundation
//import SignUp

public struct OnboardingView: View {
//  let signUpTest: SignUpUsecaseInterface = SignUpUsecase.makeObject()
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
