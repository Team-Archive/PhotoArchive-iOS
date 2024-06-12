//
//  SignInRepository.swift
//  Domain
//
//  Created by Aaron Hanwe LEE on 6/12/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import ArchiveFoundation
import Foundation

public protocol SignInRepository {
  func signIn(_ oauthSignInData: OAuthSignInData) async -> Result<ServiceSignInResponse, ArchiveError>
}
