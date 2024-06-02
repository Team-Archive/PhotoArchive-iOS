//
//  OAuthGoogle.swift
//  OAuthGoogle
//
//  Created by Aaron Hanwe LEE on 5/27/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import ArchiveFoundation
import Foundation

public final class OAuthGoogle: NSObject, OAuth {
  
  // MARK: - private properties
  
  // MARK: - internal properties
  
  // MARK: - life cycle
  
  // MARK: - private method
  
  // MARK: - internal method
  
  public func oauthSignIn() async -> Result<OAuthSignInData, ArchiveError> {
    // FIXME: 개발해야함
    return .failure(.init(.commonError))
  }
  

}
