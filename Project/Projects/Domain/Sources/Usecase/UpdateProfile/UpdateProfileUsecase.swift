//
//  UpdateProfileUsecase.swift
//  Domain
//
//  Created by Aaron Hanwe LEE on 5/27/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import ArchiveFoundation
import Foundation
import Photos

public protocol UpdateProfileUsecase {
  func updateProfilePhoto(signInToken: SignInToken, asset: PHAsset) async -> Result<Void, ArchiveError>
  func isValidateNickname(nickName: String, maxLength: Int) async -> Result<ValidNicknameResponse, ArchiveError>
  func updateName(signInToken: SignInToken, name: String) async -> Result<Void, ArchiveError>
  func updateLocation(signInToken: SignInToken, city: City) async -> Result<Void, ArchiveError>
  func updateAvtivityTime(signInToken: SignInToken, city: City, activityTime: [DaysOfTheWeek: [ActivityTimeInterval]]) async -> Result<Void, ArchiveError>
}
