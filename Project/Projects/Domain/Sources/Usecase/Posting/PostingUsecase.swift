//
//  PostingUsecase.swift
//  Domain
//
//  Created by Aaron Hanwe LEE on 5/22/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import ArchiveFoundation
import Photos

public protocol PostingUsecase {
  func assetListToImageDataList(assetList: [PHAsset]) async -> Result<[Data], ArchiveError>
  func isValidContents(contents: String?) -> Bool
  func post(accessToken: String, itemList: [PostingItem], toUserIdList: [String]) async -> Result<Void, ArchiveError>
}
