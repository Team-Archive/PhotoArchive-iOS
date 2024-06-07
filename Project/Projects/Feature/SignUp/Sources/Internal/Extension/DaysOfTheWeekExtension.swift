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
      return L10n.Localizable.signUpSetActivityTimeMonday
    case .tuesday:
      return L10n.Localizable.signUpSetActivityTimeTuesday
    case .wednesday:
      return L10n.Localizable.signUpSetActivityTimeWednesday
    case .thursday:
      return L10n.Localizable.signUpSetActivityTimeThursday
    case .friday:
      return L10n.Localizable.signUpSetActivityTimeFriday
    case .saturday:
      return L10n.Localizable.signUpSetActivityTimeSaturday
    case .sunday:
      return L10n.Localizable.signUpSetActivityTimeSunday
    }
  }
}
