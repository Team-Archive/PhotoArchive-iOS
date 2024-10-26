//
//  CalendarUsercaseImpl.swift
//  Domain
//
//  Created by jinyoung on 6/11/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import ArchiveFoundation

public final class CalendarUsecaseImpl: CalendarUsecase {
  private let repository: CalendarRepository
  
  private var currentMonth: [ATCalendar] = []
  private var currentWeek: [[ATCalendar]] = []
  
  public init(repository: CalendarRepository) {
    self.repository = repository
  }
  
  public func fetchMonthDatasource(target month: Date) async throws -> [ATCalendar] {
    let currentMonth = try await repository.fetchDatasource(with: month)
    self.currentMonth = currentMonth
    self.currentWeek = convertToWeekData(month: currentMonth)
    return currentMonth
  }
  
  public func fetchWeekDatasource(target date: Date) async throws -> [ATCalendar] {
    if let targetIndex = currentMonth.firstIndex(where: {$0.date == date}),
       let weekData = currentWeek[safe: targetIndex / 7] {
      return weekData
    } else {
      guard let monthData = try? await fetchMonthDatasource(target: date),
            let targetIndex = monthData.firstIndex(where: {$0.date == date}),
            let weekData = currentWeek[safe: targetIndex / 7] else { return [] }
      return weekData
      
    }
  }
  
  public func fetchWeekDay() -> [String] {
    return repository.fetchWeekDay()
  }
  
  public func fetchNextMonth(target month: Date) -> Date? {
    return Calendar.current.date(byAdding: .month, value: 1, to: month)
  }
  
  public func fetchPreviousMonth(target month: Date) -> Date? {
    return Calendar.current.date(byAdding: .month, value: -1, to: month)
  }
  
  func convertToWeekData(month: [ATCalendar]) -> [[ATCalendar]] {
      return stride(from: 0, to: month.count, by: 7).map { startIndex in
          let endIndex = min(startIndex + 7, month.count)
          return Array(month[startIndex..<endIndex])
      }
  }
}
