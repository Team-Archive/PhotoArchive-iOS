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

public final class ArchiveError: Error {
  
  public enum ErrorFrom: String {
    case own
    case server
    case network
  }
  
  // MARK: - private property
  
  // MARK: - property
  
  public let code: Int
  public let archiveErrorCode: ArchiveErrorCode?
  public let from: ErrorFrom
  public let titleMessage: String
  public let messageValue: String
  public let originMessage: String
  
  // MARK: - life cycle
  
  public init(from: ErrorFrom, code: Int, message: String, originMessage: String? = nil, titleMessage: String? = nil, archiveErrorCode: ArchiveErrorCode? = nil) {
    self.from = from
    self.code = code
    
    let message: String = {
      switch from {
      case .own:
        return message
      case .server:
        return message
      default:
        return message
      }
    }()
    
    self.messageValue = message
    self.archiveErrorCode = archiveErrorCode
    if let originMessage {
      self.originMessage = originMessage
    } else {
      self.originMessage = message
    }
    self.titleMessage = titleMessage ?? "Error"
  }
  
  public convenience init(_ errorCode: ArchiveErrorCode) {
    self.init(
      from: .own,
      code: errorCode.rawValue,
      message: ArchiveError.messageFromArchiveErrorCode(errorCode),
      titleMessage: ArchiveError.titleMessageFromArchiveErrorCode(errorCode),
      archiveErrorCode: errorCode
    )
  }
  
  // MARK: - private method
  
  private static func messageFromArchiveErrorCode(_ code: ArchiveErrorCode) -> String {
    var returnValue: String = ""
    return returnValue
  }
  
  private static func titleMessageFromArchiveErrorCode(_ code: ArchiveErrorCode) -> String {
    var returnValue: String = ""
    return returnValue
  }
  
  // MARK: - method
  
  public func message() -> String {
    return "\(self.messageValue)\n[\(self.code)]"
  }
  
}
