//
//  DaysOfTheWeekExtension.swift
//  SignUp
//
//  Created by Aaron Hanwe LEE on 6/7/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import ArchiveFoundation
import UIComponents
import Foundation

extension DaysOfTheWeek {
  var localizedName: String {
    switch self {
    case .monday:
      return L10n.Localizable.commonShortMonday
    case .tuesday:
      return L10n.Localizable.commonShortTuesday
    case .wednesday:
      return L10n.Localizable.commonShortWednesday
    case .thursday:
      return L10n.Localizable.commonShortThursday
    case .friday:
      return L10n.Localizable.commonShortFriday
    case .saturday:
      return L10n.Localizable.commonShortSaturday
    case .sunday:
      return L10n.Localizable.commonShortSunday
    }
  }
}
