//
//  PhotoArchiveApp.swift
//  PhotoArchive
//
//  Created by hanwe on 1/28/24.
//

import SwiftUI
import ArchiveFoundation
import UIComponents
import PartialSheet
import Domain
import Data

@main
struct MyApp: App {
  
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
  @State var splashIsDone: Bool = false
  let mainContentView = MainContentView(reducer: MainReducer())
  
  var body: some Scene {
    WindowGroup {
        mainContentView
    }
    .onChange(of: scenePhase) { newPhase in
      switch newPhase {
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

