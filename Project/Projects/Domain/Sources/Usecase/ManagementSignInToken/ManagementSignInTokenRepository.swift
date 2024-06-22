//
//  ManagementSignInTokenRepository.swift
//  Domain
//
//  Created by hanwe on 6/22/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import ArchiveFoundation

public protocol ManagementSignInTokenRepository {
  func refreshSignInToken(refreshToken: String) async -> Result<SignInToken, ArchiveError>
}
