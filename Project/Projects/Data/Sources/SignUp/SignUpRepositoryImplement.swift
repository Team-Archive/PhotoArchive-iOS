//
//  SignUpRepositoryImplement.swift
//  Data
//
//  Created by hanwe on 10/20/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import Domain
import ArchiveFoundation
import DomainInterface

public final class SignUpRepositoryImplement: SignUpRepository {
  
  public init() {
    
  }
  
  public func signUp(oauthData: OAuthSignInData) async -> Result<SignInToken, ArchiveError> {
    // TODO: 구현
    return .failure(.init(.commonError))
  }
  
  
}
