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
  func updateProfilePhoto(asset: PHAsset) async -> Result<Void, ArchiveError>
  func isValidateNickname(nickName: String, maxLength: Int) async -> Result<ValidNicknameResponse, ArchiveError>
  func updateName(_ name: String) async -> Result<Void, ArchiveError>
}
