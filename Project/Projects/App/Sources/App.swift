//
//  PhotoArchiveApp.swift
//  PhotoArchive
//
//  Created by hanwe on 1/28/24.
//

import SwiftUI
import ArchiveFoundation
import Onboarding
import AppstoreSearch

@main
struct PhotoArchiveApp: App {
  
  var body: some Scene {
    WindowGroup {
      AppstoreSearch()
    }
  }
}
