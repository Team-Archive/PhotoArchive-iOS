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
    case selectDay(Date)
    case setMode(CalendarMode)
    case makeDatasource(Date)
    case setDatasource([ATCalendar])
  }
  
  public struct State: Equatable {
    var selectedMonth: Date
    var selectedDay: Date?
    var datasource: [ATCalendar] = []
    var weekDayList: [String] = []
    var mode: CalendarMode
    
    public init(
      selectedMonth: Date,
      selectedDay: Date?,
      datasource: [ATCalendar],
      weekDayList: [String],
      mode: CalendarMode
    ) {
      self.selectedMonth = selectedMonth
      self.selectedDay = selectedDay
      self.datasource = datasource
      self.weekDayList = weekDayList
      self.mode = mode
    }
  }
  
  // MARK: - Private Property
  private let useCase: CalendarUsecase
  
  // MARK: - Public Property
  public var initialState: State
  
  // MARK: - LifeCycle
  public init(
    selectedMonth: Date,
    selectedDay: Date? = nil,
    useCase: CalendarUsecase
  ) {
    let weekDay = useCase.fetchWeekDay()
    
    self.initialState = State(
      selectedMonth: selectedMonth,
      selectedDay: selectedDay,
      datasource: [],
      weekDayList: weekDay,
      mode: selectedDay != nil ? .week : .month
    )
    self.useCase = useCase
  }
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .selectNextMonth:
        if let nextMonth = useCase.fetchNextMonth(target: state.selectedMonth) {
          state.selectedMonth = nextMonth
          
          return .concatenate(.run(operation: { send in
            await send(.makeDatasource(nextMonth))
          }))
        } else {
          return .none
        }
      case .selectPreviousMonth:
        if let previousMonth = useCase.fetchPreviousMonth(target: state.selectedMonth) {
          state.selectedMonth = previousMonth
          return .concatenate(.run(operation: { send in
            await send(.makeDatasource(previousMonth))
          }))
        } else {
          return .none
        }
      case .makeDatasource(let date):
        return .run { send in
          let result = await self.makeMonthDataSource(with: date)
          await send(.setDatasource(result))
        }
      case .setDatasource(let datasource):
        state.datasource = datasource
        return .none
      case .setMode(let mode):
        state.mode = mode
        if mode == .month {
          let selectedMonth = state.selectedMonth
          return .concatenate(.run(operation: { send in
            await send(.makeDatasource(selectedMonth))
          }))
        } else {
          return .none
        }
      case .selectDay(let date):
        state.selectedDay = date
        state.mode = .week
        return .run { send in
          let result = await self.makeWeekDataSource(with: date)
          await send(.setDatasource(result))
        }
      }
    }
  }
  
  // MARK: - Private Method
  private func makeMonthDataSource(with date: Date) async -> [ATCalendar] {
    guard let result = try? await useCase.fetchMonthDatasource(target: date) else {
      return [ATCalendar]()
    }
    
    return result
  }
  
  private func makeWeekDataSource(with date: Date) async -> [ATCalendar] {
    guard let result = try? await useCase.fetchWeekDatasource(target: date) else {
      return [ATCalendar]()
    }
    
    return result
  }
}
