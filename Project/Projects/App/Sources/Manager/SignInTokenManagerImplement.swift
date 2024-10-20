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
import Data
import DomainInterface
import Combine

final class SignInManagerImplement: SignInTokenManager, MyInformationManager {
  
  // MARK: - private properties
  
  private var readWriteDataUsecase: ReadWriteDataUsecase
  private var tokenRefresher: TokenRefresher
  
  private let readWriteTokenDataKey: String = "tokenForAutoLogin"
  
  // MARK: - internal properties
  
  var isLoggedInStream: CurrentValueSubject<Bool, Never> = .init(false)
  var signInTokenStream: CurrentValueSubject<SignInToken?, Never> = .init(nil)
  var infomationStream: CurrentValueSubject<UserInformation?, Never> = .init(nil)
  private(set) var signInToken: SignInToken? {
    didSet {
      guard oldValue != signInToken else { return }
      if let signInToken {
        print("access Token: \(signInToken.accessToken)")
        NotificationCenter.default.post(name: NSNotification.Name(NotificationDefine.USER_LOGGED_IN_NOTIFICATION_DEFINE), object: self)
        self.signInTokenStream.send(signInToken)
        self.isLoggedInStream.send(true)
        Task {
          if let data = signInToken.toJsonData() {
            _ = await self.readWriteDataUsecase.write(
              key: self.readWriteTokenDataKey,
              data: data
            )
          }
        }
      } else {
        NotificationCenter.default.post(name: NSNotification.Name(NotificationDefine.USER_LOGGED_OUT_NOTIFICATION_DEFINE), object: self)
        self.signInTokenStream.send(nil)
        self.isLoggedInStream.send(false)
        Task {
          _ = await self.readWriteDataUsecase.delete(key: self.readWriteTokenDataKey)
        }
      }
    }
  }
  
  static let shared = SignInManagerImplement()
  
  
  // MARK: - life cycle
  
  private init() {
    self.readWriteDataUsecase = ReadWriteDataUsecaseImplement(repository: SecureLocalReadWriteDataRepositoryImplement(service: Bundle.main.bundleIdentifier ?? "com.archive.aboutTime"))
    self.tokenRefresher = TokenRefresher(tokenUsecase: ManagementSignInTokenUsecaseImplement(repository: ManagementSignInTokenRepositoryImplement()))
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
  func refreshSignInToken() async -> Result<Void, ArchiveError> {
    guard let currentToken = signInToken else { return .failure(.init(.isNotLoggedIn)) }
    let result = await tokenRefresher.refreshSignInToken(token: currentToken)
    switch result {
    case .success(let newToken):
      self.signInToken = newToken
      return .success(())
    case .failure(let err):
      return .failure(err)
    }
  }
  
  func setSignInToken(_ token: SignInToken) async { // login
    self.signInToken = token
  }
  
  func removeSignInToken() async { // logout
    self.signInToken = nil
    _ = await self.readWriteDataUsecase.delete(key: self.readWriteTokenDataKey)
  }
  
  func trySetSignInTokenFromSavedToken() async -> Bool {
    let tokenDataResult = await self.readWriteDataUsecase.read(key: self.readWriteTokenDataKey, as: Data.self) // FIXME: Data타입으로 하는게 아닌 그냥 자체 타입으로도 가능할듯
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
  
  func launchApp(isAppFirstRun: Bool) async {
    if isAppFirstRun {
      await self.removeSignInToken()
    } else {
      _ = await self.trySetSignInTokenFromSavedToken()
    }
  }
  
}

actor TokenRefresher {
  
  // MARK: - private properties
  
  private var isRefreshingToken = false
  private var pendingRefreshTasks = [CheckedContinuation<Result<SignInToken, ArchiveError>, Never>]()
  private var tokenUsecase: ManagementSignInTokenUsecase
  
  // MARK: - internal properties
  
  // MARK: - life cycle
  
  init(tokenUsecase: ManagementSignInTokenUsecase) {
    self.tokenUsecase = tokenUsecase
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
  func refreshSignInToken(token: SignInToken) async -> Result<SignInToken, ArchiveError> {
    if self.isRefreshingToken {
      return await withCheckedContinuation { continuation in
        self.pendingRefreshTasks.append(continuation)
      }
    }
    
    self.isRefreshingToken = true
    
    defer {
      self.isRefreshingToken = false
    }
    
    let result = await tokenUsecase.refreshSignInToken(signInToken: token)
    
    switch result {
    case .success(let newToken):
      for task in pendingRefreshTasks {
        task.resume(returning: .success(newToken))
      }
      pendingRefreshTasks.removeAll()
      return .success(newToken)
    case .failure(let error):
      for task in pendingRefreshTasks {
        task.resume(returning: .failure(error))
      }
      pendingRefreshTasks.removeAll()
      return .failure(error)
    }
  }
  
}
