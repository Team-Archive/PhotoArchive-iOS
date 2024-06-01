//
//  AppstoreSearchRepository.swift
//  Sample
//
//  Created by Aaron Hanwe LEE on 1/30/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import Combine
import ArchiveFoundation

public protocol AppstoreSearchRepository {
  func search(keyword: String, offset: UInt, limit: UInt) -> AnyPublisher<Result<[AppstoreApp], ArchiveError>, Never>
}
