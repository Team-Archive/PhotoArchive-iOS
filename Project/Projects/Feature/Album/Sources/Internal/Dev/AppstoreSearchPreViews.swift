//
//  AppstoreSearchPreViews.swift
//  AppstoreSearch
//
//  Created by Aaron Hanwe LEE on 2/1/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Domain
import SwiftUI

struct AppstoreSearchView_Previews: PreviewProvider {
  static var previews: some View {
    AppstoreSearchView(reducer: AppstoreSearchReducer(usecase: AppstoreSearchUsecase.makeObject(repository: AppstoreSearchRepositoryStubImplement())))
  }
}
