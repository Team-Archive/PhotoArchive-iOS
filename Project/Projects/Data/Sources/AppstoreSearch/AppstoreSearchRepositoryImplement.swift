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
import ArchiveFoundation
import SwiftyJSON

public final class AppstoreSearchRepositoryImplement: AppstoreSearchRepository {
  
  let provider = NetworkProvider<AppstoreAPI>()
  
  public init() {
    
  }
  
  deinit {
    print("\(self) deinit")
  }
  
  public func search(keyword: String, offset: UInt, limit: UInt) -> AnyPublisher<Result<[AppstoreApp], ArchiveError>, Never> {
    return provider.request(target: .search(
      keyword: keyword,
      offset: offset,
      limit: limit
    ))
    .eraseToAnyPublisher()
    .map { result in
      switch result {
      case .success(let data):
        guard let tokenRawList = try? JSON.init(data: data)["results"].array else { return .failure(.init(.dataToJsonFail)) }
        return .success(tokenRawList.compactMap { .init(rawJson: $0) })
      case .failure(let err):
        return .failure(err.toArchiveError)
      }
    }
    .eraseToAnyPublisher()
  }
  
}
