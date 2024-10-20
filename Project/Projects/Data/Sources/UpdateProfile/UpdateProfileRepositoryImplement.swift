//
//  UpdateProfileRepositoryImplement.swift
//  Data
//
//  Created by hanwe on 10/20/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import Domain
import ArchiveFoundation
import Photos

public final class UpdateProfileRepositoryImplement: UpdateProfileRepository {
  
  public init() {
    
  }
  
  public func updateProfilePhoto(signInToken: SignInToken, asset: PHAsset) async -> Result<Void, ArchiveError> {
    // TODO: 구현
    return .failure(.init(.commonError))
  }
  
  public func isDuplicatedName(_ name: String) async -> Result<Bool, ArchiveError> {
    // TODO: 구현
    return .failure(.init(.commonError))
  }
  
  public func updateName(signInToken: SignInToken, name: String) async -> Result<Void, ArchiveError> {
    // TODO: 구현
    return .failure(.init(.commonError))
  }
  
  public func updateLocation(signInToken: SignInToken, city: City) async -> Result<Void, ArchiveError> {
    // TODO: 구현
    return .failure(.init(.commonError))
  }
  
  public func updateAvtivityTime(signInToken: SignInToken, city: City, activityTime: [ActivityTimeInterval]) async -> Result<Void, ArchiveError> {
    // TODO: 구현
    return .failure(.init(.commonError))
  }
  
  
}
