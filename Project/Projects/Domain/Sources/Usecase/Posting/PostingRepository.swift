//
//  PostingRepository.swift
//  Domain
//
//  Created by Aaron Hanwe LEE on 5/22/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import ArchiveFoundation
import Foundation

public protocol PostingRepository {
  func post(accessToken: String, itemList: [PostingItem], toUserIdList: [String]) async -> Result<Void, ArchiveError>
}
