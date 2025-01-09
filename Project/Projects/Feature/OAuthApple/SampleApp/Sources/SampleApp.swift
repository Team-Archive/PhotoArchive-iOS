//
//  App.swift
//  ArchiveFoundation
//
//  Created by hanwe on 1/28/24.
//  Copyright © 2024 Archive. All rights reserved.
//

import SwiftUI
import OAuthApple
import ArchiveFoundation

@main
struct SampleApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}

struct ContentView: View {
  var body: some View {
    VStack {
      CustomSignInWithAppleButton()
        .frame(width: 200, height: 45)
        .cornerRadius(8)
        .padding()
    }
  }
}

struct CustomSignInWithAppleButton: View {
  
  @State private var currentNonce: String?
  private let module = OAuthApple()
  
  var body: some View {
    Button(action: {
      Task {
        let result = await module.oauthSignIn()
        print("result: \(result)")
      }
    }) {
      Text("Sign in with Apple")
        .foregroundColor(.white)
        .frame(width: 200, height: 45)
        .background(Color.black)
        .cornerRadius(8)
    }
  }
  

  
}
