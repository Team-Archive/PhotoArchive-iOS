//
//  OAuth.swift
//  ArchiveFoundation
//
//  Created by Aaron Hanwe LEE on 5/27/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation

public protocol OAuth {
  func oauthSignIn() async -> Result<OAuthSignInData, ArchiveError>
}

public enum OAuthSignInData: Equatable {
  case apple(token: String)
}
