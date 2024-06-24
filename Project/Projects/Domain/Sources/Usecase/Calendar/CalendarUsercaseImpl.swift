//
//  CalendarUsercaseImpl.swift
//  Domain
//
//  Created by jinyoung on 6/11/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import ArchiveFoundation

public final class CalendarUsercaseImpl: CalendarUsecase {
  let repository: CalendarRepository
  
  public init(repository: CalendarRepository) {
    self.repository = repository
  }
  
  public func fetchDatasource(with month: Date) async throws -> [ATCalendar] {
    return try await repository.fetchDatasource(with: month)
  }
  
  public func fetchWeekDay() -> [String] {
    return repository.fetchWeekDay()
  }
}
