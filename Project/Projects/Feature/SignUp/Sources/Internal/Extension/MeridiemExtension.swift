//
//  MeridiemExtension.swift
//  SignUp
//
//  Created by hanwe on 7/21/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import ArchiveFoundation
import UIComponents

extension Meridiem {
  var localizedName: String {
    switch self {
    case .am:
      return L10n.Localizable.commonForenoon
    case .pm:
      return L10n.Localizable.commonAfternoon
    }
  }
}
