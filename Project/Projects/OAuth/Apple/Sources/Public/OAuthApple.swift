//
//  OAuthApple.swift
//  OAuthApple
//
//  Created by Aaron Hanwe LEE on 5/27/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import ArchiveFoundation
import Foundation
import AuthenticationServices

public class OAuthApple: NSObject, OAuth, ASAuthorizationControllerDelegate {
  
  
  // MARK: - private properties
  
  var completion: ((Result<String, ArchiveError>) -> Void)?
  
  // MARK: - internal properties
  
  // MARK: - life cycle
  
  // MARK: - private method
  
  func performSignInWithApple() {
    let request = ASAuthorizationAppleIDProvider().createRequest()
    request.requestedScopes = [.fullName, .email]
    
    let controller = ASAuthorizationController(authorizationRequests: [request])
    controller.delegate = self
    controller.performRequests()
  }
  
  // MARK: - public method
  
  public func oauthSignIn() async -> Result<OAuthSignInData, ArchiveError> {
    return await withCheckedContinuation { continuation in
      self.completion = { result in
        switch result {
        case .success(let token):
          continuation.resume(returning: .success(.apple(token: token)))
        case .failure(let error):
          continuation.resume(returning: .failure(error))
        }
      }
      performSignInWithApple()
    }
  }
  
  // Apple ID 연동 성공 시
  public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    defer {
      self.completion = nil
    }
    switch authorization.credential {
    case let appleIDCredential as ASAuthorizationAppleIDCredential:
      guard let tokenData: Data = appleIDCredential.identityToken else { self.completion?(.failure(.init(.tokenNotExsitAppleSignIn))) ; return }
      guard let token = String(data: tokenData, encoding: .ascii) else { self.completion?(.failure(.init(.tokenAsciiToStringFailAppleSignIn))) ; return }
      self.completion?(.success(token))
    default:
      self.completion?(.failure(.init(.unexpectedAppleSignIn)))
    }
  }
  
  // Apple ID 연동 실패 시
  public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    defer {
      self.completion = nil
    }
    if (error as NSError).code != 1001 { // 사용자 취소
      self.completion?(.failure(ArchiveError.init(from: .appleOAuth, code: (error as NSError).code, message: error.localizedDescription)))
    }
  }
  
}
