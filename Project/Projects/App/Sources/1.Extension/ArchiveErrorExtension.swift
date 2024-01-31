//
//  ArchiveErrorExtension.swift
//  App
//
//  Created by Aaron Hanwe LEE on 1/31/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import ArchiveFoundation

extension ArchiveError {
  
  var title: String {
    switch self.from {
    case .network:
      return L10n.Localizable.commonErrorTitleFromNetwork
    case .own:
      return L10n.Localizable.commonErrorTitle
    case .server:
      return L10n.Localizable.commonErrorTitleFromServer
    }
  }
  
  var message: String {
    switch self.from {
    case .own:
      if let localCode = self.archiveErrorCode {
        switch localCode {
        default:
          return L10n.Localizable.commonErrorMessage + "\n" + "[\(self.code)]"
        }
      } else {
        return L10n.Localizable.commonErrorMessage + "\n" + "[\(self.code)]"
      }
    case .server:
      return L10n.Localizable.commonErrorMessage + "\n" + "[\(self.code)]"
    case .network:
      return L10n.Localizable.commonErrorMessage + "\n" + "[\(self.code)]"
    }
  }
  
}
