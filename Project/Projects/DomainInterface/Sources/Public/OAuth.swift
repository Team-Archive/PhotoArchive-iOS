//
//  OAuth.swift
//  DomainInterface
//
//  Created by hanwe on 10/6/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import ArchiveFoundation

public protocol OAuth {
  func oauthSignIn() async -> Result<OAuthSignInData, ArchiveError>
}

public enum OAuthSignInData: Equatable {
  case apple(token: String)
  case google(token: String)
  case facebook(token: String)
}

public enum OAuthProvider: Equatable, Codable {
  case apple
  case google
  case facebook
}
