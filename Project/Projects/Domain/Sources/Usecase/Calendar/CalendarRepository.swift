//
//  CalendarRepository.swift
//  Domain
//
//  Created by jinyoung on 6/11/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import ArchiveFoundation

public protocol CalendarRepository {
  func fetchDatasource(with month: Date) async throws -> [ATCalendar]
  func fetchWeekDay() -> [String]
}
