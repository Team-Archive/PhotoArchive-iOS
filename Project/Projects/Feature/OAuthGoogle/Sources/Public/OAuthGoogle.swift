//
//  OAuthGoogle.swift
//  OAuthGoogle
//
//  Created by Aaron Hanwe LEE on 5/27/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import GoogleSignIn
import ArchiveFoundation
import DomainInterface
import AuthenticationServices

public class OAuthGoogle: NSObject, OAuth {
  
  // MARK: - private properties
  
  private weak var fromViewController: UIViewController?
  
  
  // MARK: - internal properties

  // MARK: - life cycle
  
  public init(fromViewController: UIViewController?) {
    self.fromViewController = fromViewController
  }
  
  // MARK: - public method
  
  @MainActor
  public func oauthSignIn() async -> Result<OAuthSignInData, ArchiveError> {
    return await withCheckedContinuation { [weak self] continuation in
      guard let fromViewController = self?.fromViewController else {
        continuation.resume(returning: .failure(.init(.notFoundTopViewController)))
        return
      }
      
      GIDSignIn.sharedInstance.signIn(withPresenting: fromViewController) { signInResult, error in
        if let error = error {
          if (error as NSError).code == -5 {
            continuation.resume(returning: .failure(.init(.userCancel)))
          } else {
            continuation.resume(returning: .failure(.init(.unexpectedGoogleSignIn)))
          }
          return
        }
        guard let result = signInResult else {
          continuation.resume(returning: .failure(.init(.unexpectedGoogleSignIn)))
          return
        }
        guard let token = signInResult?.user.accessToken.tokenString else {
          continuation.resume(returning: .failure(.init(.tokenNotExistGoogleSignIn)))
          return
        }
        continuation.resume(returning: .success(.google(token: token)))
      }
    }
  }
}

