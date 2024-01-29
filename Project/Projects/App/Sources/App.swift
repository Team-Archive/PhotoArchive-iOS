//
//  PhotoArchiveApp.swift
//  PhotoArchive
//
//  Created by hanwe on 1/28/24.
//

import SwiftUI
import ArchiveFoundation
import Onboarding

@main
struct PhotoArchiveApp: App {
  
  let test = ArchiveFoundationTest(test: "")
  
  var body: some Scene {
    WindowGroup {
      OnboardingView()
    }
  }
}
