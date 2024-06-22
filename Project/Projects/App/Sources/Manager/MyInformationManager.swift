//
//  MyInformationManager.swift
//  App
//
//  Created by hanwe on 6/22/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import ArchiveFoundation
import Domain
import Data

// swiftlint:disable implicit_getter
final class MyInformationManager {
  
  // MARK: - private properties
  
  // MARK: - internal properties
  
  static let shared = MyInformationManager()
  let signInTokenManager: SignInTokenManagerImplement = SignInTokenManagerImplement.shared
  private(set) var myInfomation: UserInformation?
  
  var isLoggedIn: Bool {
    get async {
      let token = await signInTokenManager.signInToken
      return token != nil
    }
  }
  
  // MARK: - life cycle
  
  private init() { }
  
  // MARK: - private method
  
  // MARK: - internal method
  
  func launchApp() async {
    await signInTokenManager.configure(
      tokenUsecase: ManagementSignInTokenUsecaseImplement(repository: ManagementSignInTokenRepositoryImplement()),
      readWriteDataUsecase: ReadWriteDataUsecaseImplement(repository: SecureLocalReadWriteDataRepositoryImplement(service: Bundle.main.bundleIdentifier ?? "com.archive.AboutTime"))
    )
    _ = await signInTokenManager.trySetSignInTokenFromSavedToken()
  }

}
