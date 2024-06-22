//
//  PhotoArchiveApp.swift
//  PhotoArchive
//
//  Created by hanwe on 1/28/24.
//

import SwiftUI
import ArchiveFoundation

@main
struct MyApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    .onChange(of: scenePhase) { old, new in
      switch new {
      case .active:
        NotificationCenter.default.post(name: NSNotification.Name(NotificationDefine.APP_DID_BECOME_ACTIVE_NOTIFICATION_DEFINE), object: self)
      case .inactive:
        NotificationCenter.default.post(name: NSNotification.Name(NotificationDefine.APP_WILL_RESIGN_ACTIVE_NOTIFICATION_DEFINE), object: self)
      case .background:
        NotificationCenter.default.post(name: NSNotification.Name(NotificationDefine.APP_DID_ENTER_BACKGROUND_NOTIFICATION_DEFINE), object: self)
      @unknown default:
        break
      }
    }
  }
  
  @Environment(\.scenePhase) private var scenePhase
}
