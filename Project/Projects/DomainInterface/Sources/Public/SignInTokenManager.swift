//
//  SignInTokenManager.swift
//  DomainInterface
//
//  Created by hanwe on 10/6/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import ArchiveFoundation
import Combine

public protocol SignInTokenManager {
  
  var signInToken: SignInToken? { get }
  var signInTokenStream: CurrentValueSubject<SignInToken?, Never> { get }
  
  func refreshSignInToken() async -> Result<Void, ArchiveError>
  func setSignInToken(_ token: SignInToken) async // 로그인
  func removeSignInToken() async // 로그아웃
  func trySetSignInTokenFromSavedToken() async -> Bool
  
}
