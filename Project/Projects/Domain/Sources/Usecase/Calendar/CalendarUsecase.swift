//
//  CalendarUsecase.swift
//  Domain
//
//  Created by jinyoung on 6/11/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import ArchiveFoundation

public protocol CalendarUsecase {
  func fetchMonthDatasource(target month: Date) async throws -> [ATCalendar]
  func fetchWeekDatasource(target date: Date) async throws -> [ATCalendar]
  func fetchNextMonth(target month: Date) -> Date?
  func fetchPreviousMonth(target month: Date) -> Date?
  func fetchWeekDay() -> [String]
}
