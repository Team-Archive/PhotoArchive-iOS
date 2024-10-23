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
import SwiftUI

public enum SignUpActivityTime: Hashable, CaseIterable {
  case morning
  case afternoon
  case evening
  case night
  
  var localizedName: String {
    switch self {
    case .morning:
      return L10n.Localizable.commonMorning
    case .afternoon:
      return L10n.Localizable.commonAfternoon
    case .evening:
      return L10n.Localizable.commonEvening
    case .night:
      return L10n.Localizable.commonNight
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
    }
  }
  
  var icon: Image {
    switch self {
    case .morning:
      return Gen.Images.morning.image
    case .afternoon:
      return Gen.Images.afternoon.image
    case .evening:
      return Gen.Images.evening.image
    case .night:
      return Gen.Images.night.image
    }
  }
  
}
