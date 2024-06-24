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
    var selectedMonth: Date
    var datasource: [ATCalendar] = []
    var weekDayList: [String] = []
    
    public init(selectedMonth: Date, datasource: [ATCalendar], weekDayList: [String]) {
      self.selectedMonth = selectedMonth
      self.datasource = datasource
      self.weekDayList = weekDayList
    }
  }
  
  // MARK: - Private Property
  private let useCase: CalendarUsecase
  
  // MARK: - Public Property
  public var initialState: State
  
  // MARK: - LifeCycle
  public init(selectedMonth: Date, useCase: CalendarUsecase) {
    let weekDay = useCase.fetchWeekDay()
    
    self.initialState = State(
      selectedMonth: selectedMonth,
      datasource: [],
      weekDayList: weekDay
    )
    self.useCase = useCase
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
    guard let result = try? await useCase.fetchDatasource(with: date) else {
      return [ATCalendar]()
    }
    
    return result
  }

  // MARK: - Public Method
}
