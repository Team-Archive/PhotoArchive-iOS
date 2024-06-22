//
//  SignInTokenManagerImplement.swift
//  App
//
//  Created by hanwe on 6/22/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import ArchiveFoundation
import Domain

actor SignInTokenManagerImplement: SignInTokenManager {
  
  // MARK: - private properties
  
  private var tokenUsecase: ManagementSignInTokenUsecase?
  private var readWriteDataUsecase: ReadWriteDataUsecase?
  private var isRefreshingToken = false
  private var pendingRefreshTasks = [CheckedContinuation<Result<Void, ArchiveError>, Never>]()
  
  private let readWriteTokenDataKey: String = "tokenForAutoLogin"
  
  // MARK: - internal properties
  
  static let shared = SignInTokenManagerImplement()
  private(set) var signInToken: SignInToken? {
    didSet {
      if let signInToken {
        NotificationCenter.default.post(name: NSNotification.Name(NotificationDefine.USER_LOGGED_IN_NOTIFICATION_DEFINE), object: self)
        Task {
          if let data = signInToken.toJsonData() {
            _ = await self.readWriteDataUsecase?.write(
              key: self.readWriteTokenDataKey,
              data: data
            )
          }
        }
      } else {
        NotificationCenter.default.post(name: NSNotification.Name(NotificationDefine.USER_LOGGED_OUT_NOTIFICATION_DEFINE), object: self)
        Task {
          _ = await self.readWriteDataUsecase?.delete(key: self.readWriteTokenDataKey)
        }
      }
    }
  }
  
  // MARK: - life cycle
  
  private init() { }
  
  // MARK: - private method
  
  // MARK: - internal method
  
  func configure(
    tokenUsecase: ManagementSignInTokenUsecase,
    readWriteDataUsecase: ReadWriteDataUsecase
  ) {
    self.tokenUsecase = tokenUsecase
    self.readWriteDataUsecase = readWriteDataUsecase
  }
  
  func refreshSignInToken() async -> Result<Void, ArchiveError> {
    guard let usecase = tokenUsecase else { return .failure(.init(.notSetRequiredValue)) }
    guard let currentToken = signInToken else { return .failure(.init(.isNotLoggedIn)) }
    
    if self.isRefreshingToken {
      return await withCheckedContinuation { continuation in
        self.pendingRefreshTasks.append(continuation)
      }
    }
    
    self.isRefreshingToken = true
    
    defer {
      self.isRefreshingToken = false
    }
    
    let result = await usecase.refreshSignInToken(refreshToken: currentToken.refreshToken)
    
    switch result {
    case .success(let newToken):
      self.signInToken = newToken
      for task in pendingRefreshTasks {
        task.resume(returning: .success(()))
      }
      pendingRefreshTasks.removeAll()
      return .success(())
    case .failure(let error):
      for task in pendingRefreshTasks {
        task.resume(returning: .failure(error))
      }
      pendingRefreshTasks.removeAll()
      return .failure(error)
    }
  }
  
  func setSignInToken(_ token: SignInToken) async { // login
    self.signInToken = token
  }
  
  func removeSignInToken() async { // logout
    self.signInToken = nil
  }
  
  func trySetSignInTokenFromSavedToken() async -> Bool {
    guard let tokenDataResult = await self.readWriteDataUsecase?.read(key: self.readWriteTokenDataKey) else { return false }
    switch tokenDataResult {
    case .success(let data):
      guard let data else { return false }
      guard let signInToken = SignInToken(fromJson: data) else { return false }
      await self.setSignInToken(signInToken)
      return true
    case .failure(_):
      return false
    }
  }

}
