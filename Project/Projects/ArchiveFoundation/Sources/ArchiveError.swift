//
//  ArchiveError.swift
//  ArchiveFoundation
//
//  Created by Aaron Hanwe LEE on 1/30/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation

public enum ArchiveErrorCode: Int, LocalizedError {
  
  // MARK: - ErrorCode 50000 ~
  
  case commonError = 50000
  case dataToJsonFail
  
}

public final class ArchiveError: Error, Equatable {
  
  public enum ErrorFrom: String, Codable {
    case own
    case server
    case network
  }
  
  // MARK: - private property
  
  // MARK: - property
  
  public let code: Int
  public let archiveErrorCode: ArchiveErrorCode?
  public let from: ErrorFrom
  public let message: String?
  
  // MARK: - life cycle
  
  public init(from: ErrorFrom, code: Int, message: String? = nil, archiveErrorCode: ArchiveErrorCode? = nil) {
    self.from = from
    self.code = code
    
    self.message = message
    self.archiveErrorCode = archiveErrorCode
  }
  
  public convenience init(_ errorCode: ArchiveErrorCode) {
    self.init(
      from: .own,
      code: errorCode.rawValue,
      message: nil,
      archiveErrorCode: errorCode
    )
  }
  
  // MARK: - private method
  
  // MARK: - method
  
  public static func == (lhs: ArchiveError, rhs: ArchiveError) -> Bool {
    return lhs.code == rhs.code
  }
  
}
