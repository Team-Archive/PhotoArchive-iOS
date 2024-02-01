//
//  AppstoreSearchRepositoryStubImplement.swift
//  AppstoreSearch
//
//  Created by Aaron Hanwe LEE on 2/1/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Domain
import ArchiveFoundation
import Combine

final class AppstoreSearchRepositoryStubImplement: AppstoreSearchRepository {
  
  func search(keyword: String, offset: UInt, limit: UInt) -> AnyPublisher<Result<[AppstoreApp], ArchiveError>, Never> {
    return Just(.success([
      .init(name: "test1"),
      .init(name: "test2"),
      .init(name: "test3"),
      .init(name: "test4"),
      .init(name: "test5"),
      .init(name: "test6"),
      .init(name: "test7"),
      .init(name: "test8"),
      .init(name: "test9"),
      .init(name: "test10")
    ])).eraseToAnyPublisher()
  }
  
  
}
