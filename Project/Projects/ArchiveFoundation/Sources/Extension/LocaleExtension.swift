//
//  LocaleExtension.swift
//  ArchiveFoundation
//
//  Created by Aaron Hanwe LEE on 4/16/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation

extension Locale {
  
  public enum Lang {
    case english
    case korean
  }
  
  public static var lang: Lang {
    if let preferredLanguages = Locale.preferredLanguages.first {
      if preferredLanguages.hasPrefix("ko") {
        return .korean
      } else {
        return .english
      }
    } else {
      return .english
    }
  }
  
}
