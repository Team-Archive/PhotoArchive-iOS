//
//  FontDefine.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 4/16/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import ArchiveFoundation

final class FontDefine: NSObject {
  enum FontType {
    case regular
    case bold
    case semiBold
    case extraBold
    
    var name: String {
      switch self {
      case .regular:
        switch Locale.lang {
        case .english:
          return "Lato-Regular"
        case .korean:
          return "AppleSDGothicNeo-Regular"
        }
      case .bold:
        switch Locale.lang {
        case .english:
          return "Lato-Bold"
        case .korean:
          return "AppleSDGothicNeo-Bold"
        }
      case .semiBold:
        switch Locale.lang {
        case .english:
          return "Lato-Semibold"
        case .korean:
          return "AppleSDGothicNeo-Semibold"
        }
      case .extraBold:
        switch Locale.lang {
        case .english:
          return "Lato-Extrabold"
        case .korean:
          return "AppleSDGothicNeo-Bold"
        }
      }
    }
  }
}
