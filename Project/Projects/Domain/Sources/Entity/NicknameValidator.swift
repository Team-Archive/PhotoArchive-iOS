//
//  NicknameValidator.swift
//  Domain
//
//  Created by Aaron Hanwe LEE on 6/4/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation

final class NicknameValidator {
  
  enum InvalidReason {
    case empty
    case onlySpace
    case overLength
  }
  
  enum Response: Equatable {
    case valid
    case invalid(InvalidReason)
  }
  
  // MARK: - private properties
  
  // MARK: - internal properties
  
  // MARK: - life cycle
  
  // MARK: - private method
  
  // MARK: - internal method
  
  func isValidate(_ nickname: String, maxLength: Int) -> Response {
    
    if nickname.isEmpty {
      return .invalid(.empty)
    }
    
    let trimmedNickname = nickname.trimmingCharacters(in: .whitespaces)
    if trimmedNickname.isEmpty {
      return .invalid(.onlySpace)
    }
    
    if nickname.count > maxLength {
      return .invalid(.overLength)
    }
    
    return .valid
  }
  
}
