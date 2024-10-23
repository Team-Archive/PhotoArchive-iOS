//
//  OAuthUsecaseFactoryImplement.swift
//  Onboarding
//
//  Created by hanwe on 10/6/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import Domain
import DomainInterface
import ArchiveFoundation

public final class OAuthUsecaseFactoryImplement: OAuthUsecaseFactory {
  
  // MARK: - private properties
  
  private let signInWithApple: OAuth
  private let signInWithGoogle: OAuth
  private let signInWithFacebook: OAuth
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  public init(signInWithApple: OAuth, signInWithGoogle: OAuth, signInWithFacebook: OAuth) {
    self.signInWithApple = signInWithApple
    self.signInWithGoogle = signInWithGoogle
    self.signInWithFacebook = signInWithFacebook
  }
  
  // MARK: - private method
  
  // MARK: - public method
  
  public func oauthSignIn(type: OAuthProvider) async -> Result<OAuthSignInData, ArchiveError> {
    switch type {
    case .apple:
      return await self.signInWithApple.oauthSignIn()
    case .google:
      return await self.signInWithGoogle.oauthSignIn()
    case .facebook:
      return await self.signInWithGoogle.oauthSignIn()
    }
  }

}
