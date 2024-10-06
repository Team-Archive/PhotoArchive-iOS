//
//  OAuthUsecaseFactory.swift
//  Onboarding
//
//  Created by Aaron Hanwe LEE on 6/12/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import DomainInterface
import ArchiveFoundation

public protocol OAuthUsecaseFactory {
  func oauthSignIn(type: OAuthProvider) async -> Result<OAuthSignInData, ArchiveError>
}
