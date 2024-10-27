//
//  UpdateProfileUsecaseImplement.swift
//  Domain
//
//  Created by Aaron Hanwe LEE on 5/27/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import ArchiveFoundation
import Foundation
import Photos

public final class UpdateProfileUsecaseImplement: UpdateProfileUsecase {
  
  // MARK: - private properties
  
  private let repository: UpdateProfileRepository
  private let nicknameValidator: NicknameValidator = NicknameValidator()
  
  // MARK: - internal properties
  
  // MARK: - life cycle
  
  public init(
    repository: UpdateProfileRepository
  ) {
    self.repository = repository
  }
  
  // MARK: - private method
  
  // MARK: - public method
  
  public func updateProfilePhoto(signInToken: SignInToken, asset: PHAsset) async -> Result<Void, ArchiveError> {
    return await self.repository.updateProfilePhoto(signInToken: signInToken, asset: asset)
  }
  
  public func isValidateNickname(nickName: String, maxLength: Int) async -> Result<ValidNicknameResponse, ArchiveError> {
    let response = self.nicknameValidator.isValidate(nickName, maxLength: maxLength)
    switch response {
    case .valid:
      return await self.repository.isDuplicatedName(nickName)
        .map {
          if $0 {
            return .invalid(.duplicated)
          } else {
            return .valid
          }
        }
    case .invalid(let invalidReason):
      switch invalidReason {
      case .empty:
        return .success(.invalid(.empty))
      case .onlySpace:
        return .success(.invalid(.onlySpace))
      case .overLength:
        return .success(.invalid(.overLength))
      }
    }
  }
  
  public func updateName(signInToken: SignInToken, name: String) async -> Result<Void, ArchiveError> {
    return await self.repository.updateName(signInToken: signInToken, name: name)
  }
  
  
  public func updateLocation(signInToken: SignInToken, city: City) async -> Result<Void, ArchiveError> {
    return await self.repository.updateLocation(signInToken: signInToken, city: city)
  }
  
  public func updateAvtivityTime(
    signInToken: SignInToken,
    city: City,
    activityTime: [ActivityTimeInterval]
  ) async -> Result<Void, ArchiveError> {
    // 시간을 합쳐줘야 할 수 있음..
    return await self.repository.updateAvtivityTime(
      signInToken: signInToken,
      city: city,
      activityTime: activityTime
    )
  }

}
