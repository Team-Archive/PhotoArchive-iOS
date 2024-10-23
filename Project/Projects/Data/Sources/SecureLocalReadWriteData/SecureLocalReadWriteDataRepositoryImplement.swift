//
//  SecureLocalReadWriteDataRepositoryImplement.swift
//  Data
//
//  Created by hanwe on 6/22/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import ArchiveFoundation
import Foundation
import Domain

public final class SecureLocalReadWriteDataRepositoryImplement: ReadWriteDateRepository {
  
  // MARK: - private properties
  
  private var service: String
  
  // MARK: - internal properties
  
  // MARK: - life cycle
  
  public init(service: String) {
    self.service = service
  }
  
  // MARK: - private method
  
  private func saveToKeychain(data: Data, account: String) -> Bool {
    if readFromKeychain(account: account) != nil {
      _ = deleteFromKeychain(account: account)
    }
    let query: [CFString: Any] = [
      kSecClass: kSecClassGenericPassword,
      kSecAttrService: self.service,
      kSecAttrAccount: account,
      kSecAttrGeneric: data
    ]
    return SecItemAdd(query as CFDictionary, nil) == errSecSuccess
  }
  
  private func readFromKeychain(account: String) -> Data? {
    let query: [CFString: Any] = [
      kSecClass: kSecClassGenericPassword,
      kSecAttrService: self.service,
      kSecAttrAccount: account,
      kSecMatchLimit: kSecMatchLimitOne,
      kSecReturnAttributes: true,
      kSecReturnData: true
    ]
    
    var item: CFTypeRef?
    if SecItemCopyMatching(query as CFDictionary, &item) != errSecSuccess { return nil }
    
    guard let existingItem = item as? [CFString: Any],
          let data = existingItem[kSecAttrGeneric] as? Data else { return nil }
    
    return data
  }
  
  private func updateFromKeychain(data: Data, account: String) -> Bool {
    
    let query: [CFString: Any] = [
      kSecClass: kSecClassGenericPassword,
      kSecAttrService: self.service,
      kSecAttrAccount: account
    ]
    let attributes: [CFString: Any] = [
      kSecAttrAccount: account,
      kSecAttrGeneric: data
    ]
    
    return SecItemUpdate(query as CFDictionary, attributes as CFDictionary) == errSecSuccess
  }
  
  private func deleteFromKeychain(account: String) -> Bool {
    let query: [CFString: Any] = [
      kSecClass: kSecClassGenericPassword,
      kSecAttrService: self.service,
      kSecAttrAccount: account
    ]
    
    return SecItemDelete(query as CFDictionary) == errSecSuccess
  }
  
  // MARK: - public method
  
  public func write(key: String, data: Data) async -> Result<Void, ArchiveError> {
    if self.saveToKeychain(data: data, account: key) {
      return .success(())
    } else {
      return .failure(.init(.dataSaveFail))
    }
  }
  
  public func read(key: String) async -> Result<Data?, ArchiveError> {
    return .success(self.readFromKeychain(account: key))
  }
  
  public func update(key: String, data: Data) async -> Result<Void, ArchiveError> {
    if updateFromKeychain(data: data, account: key) {
      return .success(())
    } else {
      return .failure(.init(.dataUpdateFail))
    }
  }
  
  public func delete(key: String) async -> Result<Void, ArchiveError> {
    if deleteFromKeychain(account: key) {
      return .success(())
    } else {
      return .failure(.init(.dataDeleteFail))
    }
  }

}
