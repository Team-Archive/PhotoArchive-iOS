//
//  ReadWriteDataUsecaseImplement.swift
//  Domain
//
//  Created by hanwe on 6/22/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import ArchiveFoundation

public actor ReadWriteDataUsecaseImplement: ReadWriteDataUsecase {
  
  // MARK: - private properties
  
  private let repository: ReadWriteDateRepository
  
  // MARK: - internal properties
  
  // MARK: - life cycle
  
  public init(repository: ReadWriteDateRepository) {
    self.repository = repository
  }
  
  // MARK: - private method
  
  // MARK: - public method
  
  public func write(key: String, data: Data) async -> Result<Void, ArchiveError> {
    return await self.repository.write(key: key, data: data)
  }
  
  public func read(key: String) async -> Result<Data?, ArchiveError> {
    return await self.repository.read(key: key)
  }
  
  public func update(key: String, data: Data) async -> Result<Void, ArchiveError> {
    return await self.repository.update(key: key, data: data)
  }
  
  public func delete(key: String) async -> Result<Void, ArchiveError> {
    return await self.repository.delete(key: key)
  }
  
}
