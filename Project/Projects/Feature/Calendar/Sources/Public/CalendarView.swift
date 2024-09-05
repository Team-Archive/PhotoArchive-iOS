//
//  CalendarView.swift
//  Calendar
//
//  Created by jinyoung on 6/11/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import UIComponents
import Domain

public struct CalendarView: View {
  
  // MARK: - public state
  public var selectHandler: ((ATCalendar?) -> Void)?
  
  // MARK: - private properties
  @Bindable private var store: StoreOf<CalendarReducer>
  
  // MARK: - public properties
  
  
  
  // MARK: - life cycle
  
  public var body: some View {
    WithViewStore(store, observe: { $0 }) { state in
      ZStack {
        VStack {
          CalendarMonthInfoView()
          CalendarWeekDayView()
          CalendarDayView()
        }.onAppear(perform: {
          store.send(.makeDatasource(state.selectedMonth))
        })
      }
    }
  }
  
  public init(reducer: CalendarReducer, selectHandler: ((ATCalendar?) -> Void)? = nil) {
    self.selectHandler = selectHandler
    self.store = StoreOf<CalendarReducer>(initialState: reducer.initialState, reducer: {
     
      return reducer
    })
  }
  
  // MARK: - private method
  @ViewBuilder
  private func CalendarMonthInfoView() -> some View {
    WithViewStore(store, observe: { $0 }) { state in
      HStack(alignment: .center) {
        Button(action: {
          state.send(.selectPreviousMonth)
        }, label: {
          Gen.Images.arrowLeft24.image
        })
        
        Text("\(state.selectedMonth.formatToyyyyM())")
          .font(.fonts(.title20))
          .foregroundStyle(Gen.Colors.white.color)
          .padding(.horizontal, 12)
        
        Button(action: {
          state.send(.selectNextMonth)
        }, label: {
          Gen.Images.arrowRight24.image
        })
      }
      .frame(maxWidth: .infinity, maxHeight: 24)
      .padding(.bottom, 20)
    }
  }
  
  @ViewBuilder
  private func CalendarWeekDayView() -> some View {
    WithViewStore(store, observe: { $0 }) { state in
      LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 40, maximum: 60), spacing: 8), count: 7)) {
        ForEach(state.weekDayList, id: \.self) { day in
          Text(day)
            .font(.fonts(.bodyBold14))
            .foregroundStyle(Gen.Colors.gray300.color)
            .frame(width: 40)
        }
      }
      .frame(maxWidth: .infinity, maxHeight: 20, alignment: .center)
      .padding(.bottom, 8)
    }
  }
  
  @ViewBuilder
  private func CalendarDayView() -> some View {
    WithViewStore(store, observe: { $0 }) { state in
      LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 40, maximum: 60), spacing: 8), count: 7), spacing: 8) {
          
          ForEach(state.datasource.indices, id: \.self) { index in
            if let day = state.datasource[safe: index]?.day, day != "" {
              ZStack {
                if let imageURL = state.datasource[safe: index]?.photoURL {
                  ATUrlImage(url: imageURL)
                    .aspectRatio(contentMode: .fill)
                }
                
                Text(day)
                  .font(.fonts(.bodyBold14))
                  .foregroundStyle(Gen.Colors.white.color)
                  .background(Color.gray.opacity(0.1))
              }.onTapGesture {
                selectHandler?(state.datasource[safe: index])
              }
              .frame(width: 40, height: 40, alignment: .center)
              .cornerRadius(12)
            } else {
              Color.clear
                .frame(width: 40, height: 40, alignment: .center)
            }
          }
      }
    }
  }
  
  // MARK: - internal method
  
}
