//
//  StubCalendarRepository.swift
//  Domain
//
//  Created by jinyoung on 6/24/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import ArchiveFoundation

public final class StubCalendarRepositoryImpl: CalendarRepository {
  
  public init() {}
  
  public func fetchDatasource(with month: Date) async throws -> [ATCalendar] {
    var datasource = [ATCalendar]()
    
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month], from: month)
    
    guard let range = calendar.range(of: .day, in: .month, for: month),
          let firstDayOfMonth = calendar.date(from: components) else {
      return datasource
    }
    
    let firstWeekDay = calendar.component(.weekday, from: firstDayOfMonth)
    datasource = [ATCalendar](repeating: .empty, count: firstWeekDay - 1)
    
    let photoData = fetchPhotoURL()
    for day in range {
      let photo = photoData[safe: day - 1] ?? nil
      let data = ATCalendar(
        date: calendar.date(byAdding: .day, value: day - 1, to: firstDayOfMonth),
        photoURL: photo
      )
      datasource.append(data)
    }
    
    return datasource
  }
  
  public func fetchWeekDay() -> [String] {
    let weekDay = [
      "일",
      "월",
      "화",
      "수",
      "목",
      "금",
      "토"
    ]
    
    return weekDay
  }
  
  private func fetchPhotoURL() -> [URL?] {
    var photoURL = Array(repeating: URL(string: ""), count: 31)
    let dummyData = MockImageURL.fetchDatas(with: 7)
    photoURL[3] = dummyData[0]
    photoURL[8] = dummyData[1]
    photoURL[9] = dummyData[2]
    photoURL[15] = dummyData[3]
    photoURL[18] = dummyData[4]
    photoURL[26] = dummyData[5]
    photoURL[27] = dummyData[6]
    
    return photoURL
  }
}
