//
//  SignUpActivityTime.swift
//  SignUp
//
//  Created by Aaron Hanwe LEE on 6/7/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import ArchiveFoundation
import Foundation
import UIComponents

enum SignUpActivityTime: Hashable {
  case morning
  case forenoon
  case afternoon
  case evening
  case night
  case dawn
  
  var localizedName: String {
    switch self {
    case .morning:
      return L10n.Localizable.commonMorning
    case .forenoon:
      return L10n.Localizable.commonForenoon
    case .afternoon:
      return L10n.Localizable.commonAfternoon
    case .evening:
      return L10n.Localizable.commonEvening
    case .night:
      return L10n.Localizable.commonNight
    case .dawn:
      return L10n.Localizable.commonDawn
    }
  }
  
  var rawValue: ActivityTimeInterval {
    switch self {
    case .morning:
      return .init(
        start: .init(
          hour: 7,
          minute: 0
        ),
        end: .init(
          hour: 9,
          minute: 0
        )
      )
    case .forenoon:
      return .init(
        start: .init(
          hour: 9,
          minute: 0
        ),
        end: .init(
          hour: 12,
          minute: 0
        )
      )
    case .afternoon:
      return .init(
        start: .init(
          hour: 12,
          minute: 0
        ),
        end: .init(
          hour: 18,
          minute: 0
        )
      )
    case .evening:
      return .init(
        start: .init(
          hour: 18,
          minute: 0
        ),
        end: .init(
          hour: 21,
          minute: 0
        )
      )
    case .night:
      return .init(
        start: .init(
          hour: 21,
          minute: 0
        ),
        end: .init(
          hour: 0,
          minute: 0
        )
      )
    case .dawn:
      return .init(
        start: .init(
          hour: 0,
          minute: 0
        ),
        end: .init(
          hour: 3,
          minute: 0
        )
      )
    }
  }
  
}
