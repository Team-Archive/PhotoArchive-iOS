//
//  SignInUsecaseImplement.swift
//  Domain
//
//  Created by Aaron Hanwe LEE on 6/12/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import ArchiveFoundation
import Foundation
import DomainInterface

public final class SignInUsecaseImplement: SignInUsecase {
  
  // MARK: - private properties
  
  private let repository: SignInRepository
  
  // MARK: - internal properties
  
  // MARK: - life cycle
  
  public init(repository: SignInRepository) {
    self.repository = repository
  }
  
  // MARK: - private method
  
  // MARK: - public method
  
  public func signIn(_ oauthSignInData: OAuthSignInData) async -> Result<ServiceSignInResponse, ArchiveError> {
    return await self.repository.signIn(oauthSignInData)
  }

}
