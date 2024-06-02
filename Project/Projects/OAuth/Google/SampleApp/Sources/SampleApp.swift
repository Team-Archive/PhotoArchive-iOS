//
//  App.swift
//  ArchiveFoundation
//
//  Created by hanwe on 1/28/24.
//  Copyright © 2024 Archive. All rights reserved.
//

import SwiftUI
import OAuthGoogle
import ArchiveFoundation
import FirebaseCore

@main
struct SampleApp: App {
  
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

struct ContentView: View {
  var body: some View {
    VStack {
      CustomSignInWithGoogleButton()
        .frame(width: 200, height: 45)
        .cornerRadius(8)
        .padding()
    }
  }
}

struct CustomSignInWithGoogleButton: View {
  
  @State private var currentNonce: String?
  private let module = OAuthGoogle()
  
  var body: some View {
    Button(action: {
      Task {
        let result = await module.oauthSignIn()
        print("result: \(result)")
      }
    }) {
      Text("Sign in with Google")
        .foregroundColor(.white)
        .frame(width: 200, height: 45)
        .background(Color.black)
        .cornerRadius(8)
    }
  }
  

  
}
