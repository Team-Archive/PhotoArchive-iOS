//
//  ValidNicknameResponse.swift
//  Domain
//
//  Created by Aaron Hanwe LEE on 6/4/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

public enum ValidNicknameResponse: Equatable {
  case valid
  case invalid(InvalidNicknameReason)
}

public enum InvalidNicknameReason: Equatable {
  case none
  case empty
  case onlySpace
  case overLength
  case duplicated
}
