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
  
  // MARK: - internal properties
  
  // MARK: - life cycle
  
  public init(repository: UpdateProfileRepository) {
    self.repository = repository
  }
  
  // MARK: - private method
  
  // MARK: - public method
  
  public func updateProfilePhoto(asset: PHAsset) async -> Result<Void, ArchiveError> {
    return await self.repository.updateProfilePhoto(asset: asset)
  }
  
  public func isDuplicatedName(_ name: String) async -> Result<Bool, ArchiveError> {
    return await self.repository.isDuplicatedName(name)
  }
  
  public func updateName(_ name: String) async -> Result<Void, ArchiveError> {
    return await self.repository.updateName(name)
  }

}
