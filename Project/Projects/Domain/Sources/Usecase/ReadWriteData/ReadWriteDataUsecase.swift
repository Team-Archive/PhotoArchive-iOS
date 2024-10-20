//
//  ReadWriteDataUsecase.swift
//  Domain
//
//  Created by hanwe on 6/22/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import ArchiveFoundation
import Foundation

public protocol ReadWriteDataUsecase {
  func write<T: Encodable>(key: String, data: T) async -> Result<Void, ArchiveError>
  func read<T: Decodable>(key: String, as type: T.Type) async -> Result<T?, ArchiveError>
  func update<T: Encodable>(key: String, data: T) async -> Result<Void, ArchiveError>
  func delete(key: String) async -> Result<Void, ArchiveError>
}
