//
//  StubCalendarRepository.swift
//  Domain
//
//  Created by jinyoung on 6/24/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import ArchiveFoundation
import UIComponents
import Domain

public final class StubCalendarRepositoryImpl: CalendarRepository {
  
  public init() {}
  
  public func fetchDatasource(with month: Date) async throws -> [ATCalendar] {
    var datasource = [ATCalendar]()
    
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month], from: month)
    
    // 1일
    guard let range = calendar.range(of: .day, in: .month, for: month),
          let firstDayOfMonth = calendar.date(from: components) else {
      return datasource
    }

    let firstWeekDay = calendar.component(.weekday, from: firstDayOfMonth)
    datasource = [ATCalendar](repeating: .empty, count: firstWeekDay - 1)
    
    let photoData = fetchPhotoURL()
    for day in 0..<range.count {
      let photo = photoData[safe: day] ?? nil
      let data = ATCalendar(
        date: calendar.date(byAdding: .day, value: day, to: firstDayOfMonth),
        photoURL: photo)
      datasource.append(data)
    }
    
    return datasource
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
  
  private func fetchPhotoURL() -> [URL?] {
    var photoURL = Array(repeating: URL(string: ""), count: 31)
    photoURL[3] = URL(string: "https://i.pinimg.com/736x/c4/60/27/c460277a39f0e704d9e1adeb0c014c55.jpg")
    photoURL[8] = URL(string: "https://i.pinimg.com/736x/12/4f/fc/124ffccb91f2db406d0d82d7ae5350c4.jpg")
    photoURL[9] = URL(string: "https://i.pinimg.com/736x/77/9f/bd/779fbd092c3a3c5a600f9c9977906fec.jpg")
    photoURL[15] = URL(string: "https://i.pinimg.com/564x/4b/29/f3/4b29f34f8b67ba483ca504a6a905e595.jpg")
    photoURL[18] = URL(string: "https://i.pinimg.com/736x/36/49/51/3649514b5df96f881f5b889be8a9b947.jpg")
    photoURL[26] = URL(string: "https://i.pinimg.com/736x/36/49/51/3649514b5df96f881f5b889be8a9b947.jpg")
    photoURL[27] = URL(string: "https://i.pinimg.com/736x/a5/42/f7/a542f775abeeea554618fec94ed78a89.jpg")
    
    return photoURL
  }
}
