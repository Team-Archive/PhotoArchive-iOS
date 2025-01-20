//
//  ATGridImageView+ImageType.swift
//  UIComponents
//
//  Created by jinyoung on 1/20/25.
//  Copyright © 2025 TeamArchive. All rights reserved.
//

import Foundation

extension ATGridImageView {
  enum ATGridImageType: Int {
    case one = 1
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    
    // 전체 타입 개수와 매핑
    static func gridType(for count: Int) -> ATGridImageType? {
        switch count {
        case 1:
          return .one
        case 2:
          return .two
        case 3:
          return .three
        case 4:
          return .four
        case 5:
          return .five
        case 6:
          return .six
        case 7:
          return .seven
        case 8:
          return .eight
        case 9:
          return .nine
        case 10:
          return .ten
        default:
          return nil
        }
    }
    
    var attributes: [ATGridImageSizeType] {
      switch self {
      case .one:
        return [.largeSquare]
      case .two:
        return [.mediumSquare]
      case .three:
        return [.smallSqure]
      case .four:
        return [.mediumSquare, .mediumSquare]
      case .five:
        return [.smallSqure, .smallRectangle]
      case .six:
        return [.smallSqure, .smallSqure]
      case .seven:
        return [.smallSqure, .smallRectangle, .smallRectangle]
      case .eight:
        return [.smallSqure, .smallRectangle, .smallRectangle]
      case .nine:
        return [.smallSqure, .smallSqure, .smallSqure]
      case .ten:
        return [.smallSqure, .smallSqure, .smallRectangle, .smallRectangle]
      }
    }
  }

}
