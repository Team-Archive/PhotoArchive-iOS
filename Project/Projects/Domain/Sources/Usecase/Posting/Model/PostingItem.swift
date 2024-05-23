//
//  PostingItem.swift
//  Domain
//
//  Created by Aaron Hanwe LEE on 5/22/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation

public struct PostingItem: Equatable {
  public let imageData: Data
  public let comment: String?
  
  public init(imageData: Data, comment: String?) {
    self.imageData = imageData
    self.comment = comment
  }
}
