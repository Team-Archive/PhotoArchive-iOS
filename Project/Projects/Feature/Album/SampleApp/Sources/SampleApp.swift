//
//  App.swift
//  ArchiveFoundation
//
//  Created by hanwe on 1/28/24.
//  Copyright © 2024 Archive. All rights reserved.
//

import SwiftUI
import AppstoreSearch
import Domain

@main
struct SampleApp: App {
  var body: some Scene {
    WindowGroup {
      AppstoreSearchView(reducer: AppstoreSearchReducer(usecase: AppstoreSearchUsecase.makeObject(repository: AppstoreSearchRepositoryStubImplement())))
    }
  }
}
