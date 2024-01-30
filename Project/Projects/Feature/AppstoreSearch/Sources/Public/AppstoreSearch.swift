//
//  AppstoreSearch.swift
//  AppstoreSearch
//
//  Created by Aaron Hanwe LEE on 1/30/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import ArchiveFoundation
import Domain
import Data

public struct AppstoreSearch: View {
  let appstoreSearchUsecase: AppstoreSearchUsecaseInterface = AppstoreSearchUsecase.makeObject(repository: AppstoreSearchRepositoryImplement())
  public var body: some View {
    VStack {
      Text("Hello, world!")
    }
    .padding()
    .onAppear {
      appstoreSearchUsecase.search(keyword: "dd")
    }
  }
  
  public init() {
    
  }
  
}

#Preview {
  AppstoreSearch()
}
