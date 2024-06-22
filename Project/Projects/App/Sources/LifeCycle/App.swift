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
import Domain
import Data

@main
struct PhotoArchiveApp: App {
  
  var body: some Scene {
    WindowGroup {
//      AppstoreSearchView(reducer: AppstoreSearchReducer(usecase: AppstoreSearchUsecase(repository: AppstoreSearchRepositoryImplement())))
      ContentView()
    }
  }
}
