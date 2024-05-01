//
//  AppstoreSearchRepositoryStubImplement.swift
//  AppstoreSearchSampleApp
//
//  Created by Aaron Hanwe LEE on 2/1/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Domain
import ArchiveFoundation
import Combine
import Foundation

final class AppstoreSearchRepositoryStubImplement: AppstoreSearchRepository {
  
  func search(keyword: String, offset: UInt, limit: UInt) -> AnyPublisher<Result<[AppstoreApp], ArchiveError>, Never> {
    return Just(())
//      .delay(for: 2, scheduler: DispatchQueue.global())
      .delay(for: 2, scheduler: DispatchQueue.main)
      .map { _ in
        return .success([
          .init(name: "test1", id: "test1"),
          .init(name: "test2", id: "test2"),
          .init(name: "test3", id: "test3"),
          .init(name: "test4", id: "test4"),
          .init(name: "test5", id: "test5"),
          .init(name: "test6", id: "test6"),
          .init(name: "test7", id: "test7"),
          .init(name: "test8", id: "test8"),
          .init(name: "test9", id: "test9"),
          .init(name: "test10", id: "test10")
        ])
      }
      .eraseToAnyPublisher()
  }
  
  
}
