//
//  ManagementSignInTokenUsecaseImplement.swift
//  Domain
//
//  Created by hanwe on 6/22/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import ArchiveFoundation
import Foundation

public final class ManagementSignInTokenUsecaseImplement: ManagementSignInTokenUsecase {
  
  // MARK: - private properties
  
  private let repository: ManagementSignInTokenRepository
  
  // MARK: - internal properties
  
  // MARK: - life cycle
  
  public init(repository: ManagementSignInTokenRepository) {
    self.repository = repository
  }
  
  // MARK: - private method
  
  // MARK: - public method
  
  public func refreshSignInToken(signInToken: SignInToken) async -> Result<SignInToken, ArchiveError> {
    return await self.repository.refreshSignInToken(signInToken: signInToken)
  }

}
