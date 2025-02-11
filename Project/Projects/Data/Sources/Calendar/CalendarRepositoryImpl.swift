//
//  CalendarRepositoryImpl.swift
//  Data
//
//  Created by jinyoung on 7/9/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import ArchiveFoundation
import UIComponents
import Domain

// TODO: 추후 API 연동 필요
public final class CalendarRepositoryImpl: CalendarRepository {
  public func fetchDatasource(with month: Date) async throws -> [ATCalendar] {
    return [ATCalendar]()
  }
  
  public func fetchWeekDay() -> [String] {
    let weekDay = [
      L10n.Localizable.commonShortSunday,
      L10n.Localizable.commonShortMonday,
      L10n.Localizable.commonShortTuesday,
      L10n.Localizable.commonShortWednesday,
      L10n.Localizable.commonShortThursday,
      L10n.Localizable.commonShortFriday,
      L10n.Localizable.commonShortSaturday
    ]
    
    return weekDay
  }
}
