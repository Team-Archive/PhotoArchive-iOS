//
//  DesignFont.swift
//  App
//
//  Created by Aaron Hanwe LEE on 3/13/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import Foundation

public enum ATFonts {
  case title28
  case title24
  case title20
  case bodyBold16
  case body16
  case bodyBold14
  case body14
  case body13
  case body12
  case buttonExtraBold14
  case buttonSemiBold14
  
  
}

extension Font {
  public static func fonts(_ font: ATFonts) -> Font {
    switch font {
    case .title28:
      return .custom(FontDefine.FontType.bold.name, size: 28)
    case .title24:
      return .custom(FontDefine.FontType.bold.name, size: 24)
    case .title20:
      return .custom(FontDefine.FontType.bold.name, size: 20)
    case .bodyBold16:
      return .custom(FontDefine.FontType.bold.name, size: 16)
    case .body16:
      return .custom(FontDefine.FontType.regular.name, size: 16)
    case .bodyBold14:
      return .custom(FontDefine.FontType.bold.name, size: 14)
    case .body14:
      return .custom(FontDefine.FontType.regular.name, size: 14)
    case .body13:
      return .custom(FontDefine.FontType.regular.name, size: 13)
    case .body12:
      return .custom(FontDefine.FontType.regular.name, size: 12)
    case .buttonExtraBold14:
      return .custom(FontDefine.FontType.bold.name, size: 14)
    case .buttonSemiBold14:
      return .custom(FontDefine.FontType.semiBold.name, size: 14)
    }
  }
}
