//
//  ATGridImageView+SizeType.swift
//  UIComponents
//
//  Created by jinyoung on 1/20/25.
//  Copyright © 2025 TeamArchive. All rights reserved.
//

import Foundation

extension ATGridImageView {
  enum ATGridImageSizeType {
    case largeSquare
    case mediumSquare
    case smallSqure
    case smallRectangle
    
    var count: Int {
      switch self {
      case .largeSquare:
        return 1
      case .mediumSquare:
        return 2
      case .smallSqure:
        return 3
      case .smallRectangle:
        return 2
      }
    }
  }

}
