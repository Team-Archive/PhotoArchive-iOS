//
//  ExpressiveEmoji.swift
//  ArchiveFoundation
//
//  Created by Aaron Hanwe LEE on 4/25/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation

public enum ExpressiveEmoji {
  case heart
  case flower
  
  public var emoji: String {
    switch self {
    case .heart:
      return "💕"
    case .flower:
      return "🌸"
    }
  }
  
}
