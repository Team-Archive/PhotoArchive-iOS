//
//  AppstoreSearchRepositoryImplement.swift
//  AppstoreSearch
//
//  Created by Aaron Hanwe LEE on 1/30/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import APIHub
import Domain
import Network_iOS
import Combine
import Foundation

public final class AppstoreSearchRepositoryImplement: AppstoreSearchRepository {
  
  public init() {
    
  }
  
  public func search(keyword: String, offset: UInt, limit: UInt) -> AnyPublisher<Data, Error> {
    let provider = NetworkProvider<AppstoreAPI>()
    return provider.request(target: .search(
      keyword: keyword,
      offset: offset,
      limit: limit
    ))
  }
  
}
