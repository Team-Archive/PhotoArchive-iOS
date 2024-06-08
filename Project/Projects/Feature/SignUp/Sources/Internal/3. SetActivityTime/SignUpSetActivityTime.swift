//
//  SignUpSetActivityTime.swift
//  SignUp
//
//  Created by hanwe on 5/26/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import UIComponents
import ArchiveFoundation
import ComposableArchitecture

struct SignUpSetActivityTime: View, SignUpStepView {
  
  // MARK: - internal state
  
  // MARK: - private properties
  
  private let store: StoreOf<SignUpReducer>
  private var nextAction: () -> Void
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  init(
    store: StoreOf<SignUpReducer>,
    nextAction: @escaping () -> Void
  ) {
    self.store = store
    self.nextAction = nextAction
  }
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      ZStack {
        Gen.Colors.backgroundSignUp.color
          .ignoresSafeArea(.all)
        VStack {
          ScrollView {
            HStack {
              Text(L10n.Localizable.signUpSetActivityTimeTitle(viewStore.selectedCity?.name ?? "-"))
                .font(.fonts(.title24))
                .foregroundStyle(Gen.Colors.white.color)
                .padding(
                  .init(
                    top: 28,
                    leading: .designContentsInset,
                    bottom: 0,
                    trailing: .designContentsInset
                  )
                )
              Spacer()
            }
            
            HStack {
              Text(L10n.Localizable.signUpSetActivityTimeContents)
                .font(.fonts(.body14))
                .foregroundStyle(Gen.Colors.gray300.color)
                .padding(
                  .init(
                    top: 4,
                    leading: .designContentsInset,
                    bottom: 0,
                    trailing: .designContentsInset
                  )
                )
              Spacer()
            }
            
            ContentsView()
              .padding(.top, 28)
          }
          
          ATBottomActionButton(
            designType: .secondary,
            title: L10n.Localizable.signUpSetActivityTimeDoneButtonTitle,
            action: {
              nextAction()
            },
            isEnabled: Binding(get: { viewStore.activityTime.values.contains(where: { !$0.isEmpty }) }, set: { _ in })
          )
        }
      }
    }
  }
  
  // MARK: - private method
  
  @ViewBuilder
  private func ContentsView() -> some View {
    
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack(spacing: 16) {
        HStack(spacing: 8) {
          ATCheckBoxView(
            title: nil,
            isHapticEnable: true,
            isChecked: Binding(
              get: { isAllTimeChecked(activityTime: viewStore.activityTime) },
              set: { _ in }),
            action: { isChecked in
              for time in SignUpActivityTime.allCases {
                for day in DaysOfTheWeek.allCases {
                  viewStore.send(.selectActiveTime(
                    willSelected: !isChecked,
                    daysOfTheWeek: day,
                    signUpActivityTime: time
                  ))
                }
              }
            }
          )
          Text(L10n.Localizable.signUpSetActivityTimeAllSelectTitle)
            .font(.fonts(.body16))
            .foregroundStyle(Gen.Colors.white.color)
          Spacer()
        }
        .padding(.designContentsSideInsets)
        Rectangle()
          .foregroundStyle(Gen.Colors.purpleGray400.color)
          .frame(height: 1)
          .padding(.designContentsSideInsets)
        ForEach(0..<SignUpActivityTime.allCases.count, id: \.self) { index in
          let item: SignUpActivityTime = SignUpActivityTime.allCases[safe: index] ?? .morning
          ActivityTimeSetView(
            activityTime: item,
            isAllChecked: Binding(
              get: { isActivityTimeIsAllChecked(activityTime: viewStore.activityTime, filter: item) },
              set: { _ in }),
            daysOfTheWeekSet: Binding(
              get: { transformActivityTime(activityTime: viewStore.activityTime, filter: item) },
              set: { _ in })
          ) { isSelected, signUpActivityTime in
            
            for day in DaysOfTheWeek.allCases {
              viewStore.send(.selectActiveTime(
                willSelected: !isSelected,
                daysOfTheWeek: day,
                signUpActivityTime: signUpActivityTime
              ))
            }
          } daySelectAction: { isSelected, daysOfTheWeek, signUpActivityTime in
            
            viewStore.send(.selectActiveTime(
              willSelected: !isSelected,
              daysOfTheWeek: daysOfTheWeek,
              signUpActivityTime: signUpActivityTime
            ))
          }
        }
        Rectangle()
          .foregroundStyle(.clear)
          .frame(height: 40)
      }
    }
    
  }
  
  private func transformActivityTime(activityTime: [DaysOfTheWeek: Set<SignUpActivityTime>], filter: SignUpActivityTime) -> Set<DaysOfTheWeek> {
    var returnValue: Set<DaysOfTheWeek> = []
    let allKeys = activityTime.keys
    for key in allKeys {
      guard let times = activityTime[key] else { continue }
      for time in times where time == filter {
        returnValue.insert(key)
      }
    }
    return returnValue
  }
  
  private func isActivityTimeIsAllChecked(activityTime: [DaysOfTheWeek: Set<SignUpActivityTime>], filter: SignUpActivityTime) -> Bool {
    return self.transformActivityTime(activityTime: activityTime, filter: filter).count == DaysOfTheWeek.allCases.count
  }
  
  private func isAllTimeChecked(activityTime: [DaysOfTheWeek: Set<SignUpActivityTime>]) -> Bool {
    for time in SignUpActivityTime.allCases where !self.isActivityTimeIsAllChecked(activityTime: activityTime, filter: time) {
      return false
    }
    return true
  }
  
  
  
  // MARK: - internal method
  
}
