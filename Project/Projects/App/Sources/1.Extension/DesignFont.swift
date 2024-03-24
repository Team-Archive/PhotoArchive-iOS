//
//  DesignFont.swift
//  App
//
//  Created by Aaron Hanwe LEE on 3/13/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import Foundation

enum ATFonts {
  case sample
}

extension Font {
  static func fonts(_ font: ATFonts) -> Font {
    var optionalReturnFont: Font?
    switch font {
    case .sample:
      optionalReturnFont = .body
    }
    
    return optionalReturnFont ?? .body
  }
}
