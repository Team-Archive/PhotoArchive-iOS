//
//  SignUpUsecaseImplement.swift
//  Domain
//
//  Created by Aaron Hanwe LEE on 5/27/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import ArchiveFoundation

public final class SignUpUsecaseImplement: SignUpUsecase {
  
  // MARK: - private properties
  
  private let repository: SignUpRepository
  
  // MARK: - internal properties
  
  // MARK: - life cycle
  
  public init(repository: SignUpRepository) {
    self.repository = repository
  }
  
  // MARK: - private method
  
  // MARK: - public method
  
  public func signUp(oauthData: OAuthSignInData) async -> Result<SignInToken, ArchiveError> {
    return await self.repository.signUp(oauthData: oauthData)
  }
  
}
