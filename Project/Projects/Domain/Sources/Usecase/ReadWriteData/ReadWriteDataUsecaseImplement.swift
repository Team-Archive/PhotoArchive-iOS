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
  
  private func writeData(key: String, data: Data) async -> Result<Void, ArchiveError> {
    return await self.repository.write(key: key, data: data)
  }
  
  private func readData(key: String) async -> Result<Data?, ArchiveError> {
    return await self.repository.read(key: key)
  }
  
  private func updateData(key: String, data: Data) async -> Result<Void, ArchiveError> {
    return await self.repository.update(key: key, data: data)
  }
  
  private func deleteData(key: String) async -> Result<Void, ArchiveError> {
    return await self.repository.delete(key: key)
  }
  
  // MARK: - public method
  
  public func write<T: Encodable>(key: String, data: T) async -> Result<Void, ArchiveError> {
    guard let encodedData = try? JSONEncoder().encode(data) else { return .failure(.init(.dataEncodingFail)) }
    return await self.writeData(key: key, data: encodedData)
  }
  
  public func read<T: Decodable>(key: String, as type: T.Type) async -> Result<T?, ArchiveError> {
    let result = await self.readData(key: key)
    switch result {
    case .success(let data):
      guard let data = data else { return .success(nil) }
      guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else { return .failure(.init(.dataDecodingFail)) }
      return .success(decodedData)
    case .failure(let error):
      return .failure(error)
    }
  }
  
  public func update<T: Encodable>(key: String, data: T) async -> Result<Void, ArchiveError> {
    guard let encodedData = try? JSONEncoder().encode(data) else { return .failure(.init(.dataEncodingFail)) }
    return await self.updateData(key: key, data: encodedData)
  }
  
  public func delete(key: String) async -> Result<Void, ArchiveError> {
    return await self.deleteData(key: key)
  }
  
}
