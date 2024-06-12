//
//  OAuthUsecaseFactory.swift
//  Onboarding
//
//  Created by Aaron Hanwe LEE on 6/12/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import OAuthApple
import ArchiveFoundation

final class OAuthUsecaseFactory {
  
  static func makeOAuthUsecase(_ type: OAuthSignInType) -> OAuth {
    switch type {
    case .apple:
      return OAuthApple()
    case .google:
      // FIXME: 구글 모듈 만들면 추가해야함
      return OAuthApple()
    case .facebook:
      // FIXME: 페이스북 모듈 만들면 추가해야함
      return OAuthApple()
    }
  }
  
}
