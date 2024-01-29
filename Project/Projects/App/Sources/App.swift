//
//  PhotoArchiveApp.swift
//  PhotoArchive
//
//  Created by hanwe on 1/28/24.
//

import SwiftUI
import ArchiveFoundation
import SignUp

@main
struct PhotoArchiveApp: App {
  
  let test = ArchiveFoundationTest(test: "")
  let signUpTest: SignUpUsecaseInterface = SignUpUsecase.makeObject()
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .onAppear {
          signUpTest.signUp()
        }
    }
  }
}
