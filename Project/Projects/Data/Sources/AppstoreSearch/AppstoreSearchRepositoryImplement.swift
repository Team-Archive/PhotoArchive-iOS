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
  
  public func search(keyword: String, offset: UInt, limit: UInt) -> AnyPublisher<[AppstoreApp], ArchiveError> {
    return provider.request(target: .search(
      keyword: keyword,
      offset: offset,
      limit: limit
    ))
    .eraseToAnyPublisher()
    .tryMap { data in
      print("data: \(data)")
      guard let tokenRawList = try? JSON.init(data: data)["results"].array else { throw ArchiveError(.dataToJsonFail) }
      return tokenRawList.compactMap {
        .init(rawJson: $0)
      }
    }
    .mapError { error -> ArchiveError in
      return .init(
        from: .server,
        code: (error as NSError).code,
        message: error.localizedDescription
      )
    }
    .eraseToAnyPublisher()
  }
  
}
