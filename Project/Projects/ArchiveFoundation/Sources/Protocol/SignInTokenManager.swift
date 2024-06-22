//
//  SignInTokenManager.swift
//  ArchiveFoundation
//
//  Created by hanwe on 6/22/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation

public protocol SignInTokenManager {
  
  var signInToken: SignInToken? { get async }
  
  func refreshSignInToken() async -> Result<Void, ArchiveError>
  func setSignInToken(_ token: SignInToken) async // 로그인
  func removeSignInToken() async // 로그아웃
  func trySetSignInTokenFromSavedToken() async -> Bool
  
}
