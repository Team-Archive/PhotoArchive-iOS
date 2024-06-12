//
//  Dummy.swift
//  ArchiveFoundation
//
//  Created by hanwe on 1/28/24.
//  Copyright © 2024 Archive. All rights reserved.
//

import ArchiveFoundation
import Foundation

public protocol SignInUsecase {
  func signIn(_ oauthSignInData: OAuthSignInData) async -> Result<ServiceSignInResponse, ArchiveError>
}
