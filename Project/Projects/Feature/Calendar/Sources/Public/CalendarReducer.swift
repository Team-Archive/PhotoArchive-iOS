//
//  CalendarReducer.swift
//  Calendar
//
//  Created by jinyoung on 6/11/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import Combine
import ComposableArchitecture
import ArchiveFoundation
import Domain
import UIComponents

public struct CalendarReducer: Reducer {
  // MARK: - TCA Define
  
  public enum Action: Equatable {
    case selectNextMonth
    case selectPreviousMonth
    case makeDatasource(Date)
    case setDatasource([ATCalendar])
  }
  
  public struct State: Equatable {
    var currentDate: Date
    var selectedMonth: Date
    var datasource: [ATCalendar]
    var weekDayList: [String] = [
      L10n.Localizable.commonShortSunday,
      L10n.Localizable.commonShortMonday,
      L10n.Localizable.commonShortTuesday,
      L10n.Localizable.commonShortWednesday,
      L10n.Localizable.commonShortThursday,
      L10n.Localizable.commonShortFriday,
      L10n.Localizable.commonShortSaturday
    ]
    
    public init(currentDate: Date = Date(), selectedMonth: Date = Date(), datasource: [ATCalendar] = []) {
      self.currentDate = currentDate
      self.selectedMonth = selectedMonth
      self.datasource = datasource
    }
  }
  
  // MARK: - Private Property
  
  // MARK: - Public Property
  public var initialState: State
  
  // MARK: - LifeCycle
  public init(initialState: State) {
    self.initialState = initialState
  }
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .selectNextMonth:
        if let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: state.selectedMonth) {
          state.selectedMonth = nextMonth
          
          return .concatenate(.run(operation: { send in
            await send(.makeDatasource(nextMonth))
          }))
        } else {
          return .none
        }
      case .selectPreviousMonth:
        if let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: state.selectedMonth) {
          state.selectedMonth = previousMonth
          return .concatenate(.run(operation: { send in
            await send(.makeDatasource(previousMonth))
          }))
        } else {
          return .none
        }
      case .makeDatasource(let date):
        return .run { send in
          let result = await self.makeDatasource(with: date)
          await send(.setDatasource(result))
        }
      case .setDatasource(let datasource):
        state.datasource = datasource
        return .none
      default:
        return .none
      }
    }
  }
  
  // MARK: - Private Method
  private func makeDatasource(with date: Date) async -> [ATCalendar] {
    var datasource = [ATCalendar]()
    
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month], from: date)
    
    // 1일
    guard let range = calendar.range(of: .day, in: .month, for: date),
          let firstDayOfMonth = calendar.date(from: components) else {
      return datasource
    }

    let firstWeekDay = calendar.component(.weekday, from: firstDayOfMonth)
    datasource = [ATCalendar](repeating: .empty, count: firstWeekDay - 1)
    
    for day in 0..<range.count {
      let data = ATCalendar(
        date: calendar.date(byAdding: .day, value: day, to: firstDayOfMonth),
        photoURL: nil,
        photo: nil)
      datasource.append(data)
    }
    
    return datasource
  }

  // MARK: - Public Method
}
