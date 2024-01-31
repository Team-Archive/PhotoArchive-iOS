//
//  ArchiveErrorExtension.swift
//  Data
//
//  Created by Aaron Hanwe LEE on 1/31/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import ArchiveFoundation
import Foundation

extension Error {
  
  var toArchiveError: ArchiveError {
    let error = self as NSError
    let from = ArchiveError.ErrorFrom(rawValue: error.domain) ?? .server
    return .init(
      from: from,
      code: error.code,
      message: error.localizedDescription
    )
  }
  
}
