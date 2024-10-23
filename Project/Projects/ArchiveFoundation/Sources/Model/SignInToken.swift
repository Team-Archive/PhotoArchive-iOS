//
//  SignInToken.swift
//  ArchiveFoundation
//
//  Created by Aaron Hanwe LEE on 6/7/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation

public struct SignInToken: Codable, Sendable, Equatable {
  public let accessToken: String
  public let refreshToken: String
  
  public init(accessToken: String, refreshToken: String) {
    self.accessToken = accessToken
    self.refreshToken = refreshToken
  }
  
  public init?(fromJson data: Data) {
    guard let token = try? JSONDecoder().decode(SignInToken.self, from: data) else { return nil }
    self = token
  }
  
  public func toJsonData() -> Data? {
    return try? JSONEncoder().encode(self)
  }
  
}
