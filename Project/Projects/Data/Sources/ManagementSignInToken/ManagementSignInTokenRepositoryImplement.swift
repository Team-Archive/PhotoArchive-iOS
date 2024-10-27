//
//  ManagementSignInTokenRepositoryImplement.swift
//  Data
//
//  Created by hanwe on 6/22/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Domain
import ArchiveFoundation

public final class ManagementSignInTokenRepositoryImplement: ManagementSignInTokenRepository {
  
  
  // MARK: - private properties
  
  // MARK: - internal properties
  
  // MARK: - life cycle
  
  public init() {
    
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
  public func refreshSignInToken(signInToken: SignInToken) async -> Result<SignInToken, ArchiveError> {
    // TODO: 개발
    return .failure(.init(.commonError))
  }

}
