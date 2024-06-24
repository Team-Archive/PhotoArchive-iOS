//
//  ActivityTimeIntervalExtension.swift
//  SignUp
//
//  Created by Aaron Hanwe LEE on 6/7/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import ArchiveFoundation

extension ActivityTimeInterval {
  public func to12HourFormat() -> String {
    return "\(start.to12HourFormat()) - \(end.to12HourFormat())"
  }
}

extension ActivityTimeInterval.Time {
  public func to12HourFormat() -> String {
    let period = hour < 12 ? "AM" : "PM"
    let hour12 = hour % 12 == 0 ? 12 : hour % 12
    return String(format: "%02d:%02d %@", hour12, minute, period)
  }
}
