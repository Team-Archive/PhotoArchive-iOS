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
  
  public func updateProfilePhoto(asset: PHAsset) async -> Result<Void, ArchiveError> {
    return await self.repository.updateProfilePhoto(asset: asset)
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
  
  public func updateName(_ name: String) async -> Result<Void, ArchiveError> {
    return await self.repository.updateName(name)
  }

}
