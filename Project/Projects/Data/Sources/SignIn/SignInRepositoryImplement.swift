//
//  SignInRepositoryImplement.swift
//  Data
//
//  Created by hanwe on 10/20/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import Domain
import ArchiveFoundation
import DomainInterface

public final class SignInRepositoryImplement: SignInRepository {
  
  public init() {
    
  }
  
  public func signIn(_ oauthSignInData: OAuthSignInData) async -> Result<ServiceSignInResponse, ArchiveError> {
    // TODO: 구현
    return .failure(.init(.commonError))
  }
  
}
