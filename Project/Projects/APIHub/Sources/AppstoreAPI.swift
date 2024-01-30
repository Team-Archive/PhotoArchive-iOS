//
//  AppstoreAPI.swift
//  Network
//
//  Created by Aaron Hanwe LEE on 1/30/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import Network_iOS

public enum AppstoreAPI {
  case search(keyword: String, offset: UInt, limit: UInt)
}

extension AppstoreAPI: TargetType {
  
  public var baseURL: URL {
    return URL(string: "https://itunes.apple.com")!
  }
  
  public var path: String {
    switch self {
    case .search:
      return "/search"
    }
  }
  
  public var method: HTTPMethod {
    switch self {
    case .search:
      return .get
    }
  }
  
  public var task: Task {
    switch self {
    case .search(let keyword, let offset, let limit):
      return .requestParameters(
        parameters: [
          "term": keyword,
          "entity": "software",
          "limit": limit,
          "offset": offset,
          "country": "KR",
          "media": "software"
        ],
        encoding: .urlEncoding)
    }
  }
  
  public var headers: [String: String]? {
    return nil
  }
  
}
