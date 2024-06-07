//
//  ActivityTimeSetView.swift
//  SignUp
//
//  Created by Aaron Hanwe LEE on 6/7/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import ArchiveFoundation
import UIComponents

public struct ActivityTimeSetView: View {
  
  // MARK: - public state
  
  // MARK: - private properties
  
  @Binding private var isAllChecked: Bool
  @Binding private var daysOfTheWeekSet: Set<DaysOfTheWeek>
  private let activityTime: SignUpActivityTime
  private let allSelectAction: (_ isSelected: Bool, _ signUpActivityTime: SignUpActivityTime) -> Void
  private let daySelectAction: (_ isSelected: Bool, _ daysOfTheWeek: DaysOfTheWeek, _ signUpActivityTime: SignUpActivityTime) -> Void
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  init(
    activityTime: SignUpActivityTime,
    isAllChecked: Binding<Bool>,
    daysOfTheWeekSet: Binding<Set<DaysOfTheWeek>>,
    allSelectAction: @escaping (_ isSelected: Bool, _ signUpActivityTime: SignUpActivityTime) -> Void,
    daySelectAction: @escaping (_ isSelected: Bool, _ daysOfTheWeek: DaysOfTheWeek, _ signUpActivityTime: SignUpActivityTime) -> Void
  ) {
    self.activityTime = activityTime
    self._isAllChecked = isAllChecked
    self._daysOfTheWeekSet = daysOfTheWeekSet
    self.allSelectAction = allSelectAction
    self.daySelectAction = daySelectAction
  }
  
  public var body: some View {
    VStack(spacing: 16) {
      TimeView()
        .padding(.designContentsSideInsets)
      DaysOfTheWeekView()
      Rectangle()
        .foregroundStyle(Gen.Colors.purpleGray400.color)
        .frame(height: 1)
        .padding(.designContentsSideInsets)
    }
  }
  
  // MARK: - private method
  
  @ViewBuilder
  private func TimeView() -> some View {
    HStack(spacing: 8) {
      ATCheckBoxView(
        title: nil,
        isChecked: self.$isAllChecked,
        action: { isChecked in
          self.allSelectAction(isChecked, self.activityTime)
        }
      )
      Text(activityTime.localizedName)
        .font(.fonts(.body16))
        .foregroundStyle(Gen.Colors.white.color)
      Text(activityTime.rawValue.to12HourFormat())
        .font(.fonts(.body14))
        .foregroundStyle(Gen.Colors.white.color)
      Spacer()
    }
  }
  
  @ViewBuilder
  private func DaysOfTheWeekView() -> some View {
    ScrollView(.horizontal) {
      let rows: [GridItem] = Array(repeating: .init(.flexible(), spacing: 0), count: 1)
      LazyHGrid(rows: rows, spacing: 12) {
        ForEach(0..<DaysOfTheWeek.allCases.count, id: \.self) { index in
          let item: DaysOfTheWeek = DaysOfTheWeek.allCases[safe: index] ?? .sunday
          ATSelectableTextButton(
            text: item.localizedName,
            isSelected: Binding(get: { self.daysOfTheWeekSet.contains(item) }, set: { _ in }),
            action: { isSelected in
              self.daySelectAction(isSelected, item, self.activityTime)
            }
          )
        }
      }
      .padding(
        .init(
          top: 0,
          leading: .designContentsInset * 2,
          bottom: 0,
          trailing: .designContentsInset * 2
        )
      )
    }
    .frame(height: 36)
  }
  
  // MARK: - internal method
  
}

#Preview {
  VStack {
    
  }
}
