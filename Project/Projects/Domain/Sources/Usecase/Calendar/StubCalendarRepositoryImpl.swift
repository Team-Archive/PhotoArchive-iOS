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
    photoURL[3] = URL(string: "https://i.pinimg.com/736x/c4/60/27/c460277a39f0e704d9e1adeb0c014c55.jpg")
    photoURL[8] = URL(string: "https://i.pinimg.com/736x/12/4f/fc/124ffccb91f2db406d0d82d7ae5350c4.jpg")
    photoURL[9] = URL(string: "https://i.pinimg.com/736x/77/9f/bd/779fbd092c3a3c5a600f9c9977906fec.jpg")
    photoURL[15] = URL(string: "https://i.pinimg.com/564x/4b/29/f3/4b29f34f8b67ba483ca504a6a905e595.jpg")
    photoURL[18] = URL(string: "https://i.pinimg.com/736x/36/49/51/3649514b5df96f881f5b889be8a9b947.jpg")
    photoURL[26] = URL(string: "https://i.pinimg.com/564x/f3/0d/0b/f30d0b66f8882a6fa86f72997deab796.jpg")
    photoURL[27] = URL(string: "https://i.pinimg.com/736x/a5/42/f7/a542f775abeeea554618fec94ed78a89.jpg")
    
    return photoURL
  }
}
