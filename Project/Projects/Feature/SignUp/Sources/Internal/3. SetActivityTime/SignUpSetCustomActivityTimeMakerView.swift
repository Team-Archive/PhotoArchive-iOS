//
//  SignUpSetCustomActivityTimeMakerView.swift
//  SignUp
//
//  Created by hanwe on 7/21/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import UIComponents
import ArchiveFoundation

struct SignUpSetCustomActivityTimeMakerView: View {
  
  enum FocusEditTimeFromTo {
    case start
    case end
  }
  
  // MARK: - internal state
  
  // MARK: - private properties
  
  private let saveAction: (ActivityTimeInterval) -> Void
  private let closeAction: () -> Void
  
  @State private var focusedFromToEdit: FocusEditTimeFromTo = .start
  @State private var focusedFromMeridiem: Meridiem = .am
  @State private var focusedToMeridiem: Meridiem = .am
  @State private var selectedFromTime: ActivityTimeInterval.Time = .init(hour: 9, minute: 0)
  @State private var selectedToTime: ActivityTimeInterval.Time = .init(hour: 10, minute: 0)

  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  init(
    saveAction: @escaping (ActivityTimeInterval) -> Void,
    closeAction: @escaping () -> Void
  ) {
    self.saveAction = saveAction
    self.closeAction = closeAction
  }
  
  var body: some View {
    VStack {
      VStack {
        VStack(spacing: 24) {
          Text(L10n.Localizable.signUpSetActivityTimeMakeCustomTimeTitle)
            .font(.fonts(.title20))
            .foregroundStyle(Gen.Colors.white.color)
            .padding(.top, 40)
          editView()
        }
        HStack(spacing: 12) {
          ATBottomActionButton(
            designType: .secondary,
            title: L10n.Localizable.commonSave,
            action: {
              self.saveAction(.init(start: self.selectedFromTime, end: self.selectedToTime))
            },
            isEnabled: .constant(true)
          )
        }
        .padding(.designContentsSideInsets)
        .padding(.top, 20)
      }
      .padding(.designContentsSideInsets)
    }
    .background(Gen.Colors.purpleGray400.color.ignoresSafeArea())
  }
  
  // MARK: - private method
  
  @ViewBuilder
  private func editView() -> some View {
    VStack(spacing: 24) {
      focusSelectView()
      ATDivider(type: .small)
      switch self.focusedFromToEdit {
      case .start:
        timeFromPickerView()
          .frame(width: 200, height: 200)
      case .end:
        timeToPickerView()
          .frame(width: 200, height: 200)
      }
    }
  }
  
  @ViewBuilder
  private func focusSelectView() -> some View {
    HStack(spacing: 12) {
      HStack(spacing: 12) {
        timeDisplayView(type: .start, isFocused: focusedFromToEdit == .start)
        Text("-")
          .font(.fonts(.title28))
          .foregroundStyle(Gen.Colors.white.color)
        timeDisplayView(type: .end, isFocused: focusedFromToEdit == .end)
      }
      Spacer()
      meridiemDisplayView(
        type: self.focusedFromToEdit,
        selected: self.focusedFromToEdit == .start ? self.focusedFromMeridiem : self.focusedToMeridiem
      )
    }
    .frame(height: 72)
  }
  
  private func timeDisplayView(type: FocusEditTimeFromTo, isFocused: Bool) -> some View {
    Button(action: {
      self.focusedFromToEdit = type
    }, label: {
      VStack {
        Text(type == .start ? self.selectedFromTime.to12HourFormat() : self.selectedToTime.to12HourFormat())
          .font(.fonts(.title24))
          .foregroundStyle(isFocused ? Gen.Colors.purple.color : Gen.Colors.white.color)
          .padding([.leading, .trailing], 20)
          .padding([.top, .bottom], 20)
      }
      .background(Gen.Colors.purpleGray300.color)
      .clipShape(RoundedRectangle(cornerRadius: 8))
    })
  }
  
  private func meridiemDisplayView(type: FocusEditTimeFromTo, selected: Meridiem) -> some View {
    VStack {
      Button(action: {
        switch type {
        case .start:
          self.focusedFromMeridiem = .am
        case .end:
          self.focusedToMeridiem = .am
        }
      }, label: {
        switch self.focusedFromToEdit {
        case .start:
          ATSelectableButton(
            contentsView: Text(Meridiem.am.localizedName)
              .font(.fonts(.body14))
              .foregroundStyle(Gen.Colors.white.color),
            isSelected: Binding(get: { self.focusedFromMeridiem == .am }, set: { _ in })
          ) { isSelected in
              self.focusedFromMeridiem = .am
          }
        case .end:
          ATSelectableButton(
            contentsView: Text(Meridiem.am.localizedName)
              .font(.fonts(.body14))
              .foregroundStyle(Gen.Colors.white.color),
            isSelected: Binding(get: { self.focusedToMeridiem == .am }, set: { _ in })
          ) { isSelected in
              self.focusedToMeridiem = .am
          }
        }
      })
      Button(action: {
        switch type {
        case .start:
          self.focusedFromMeridiem = .pm
        case .end:
          self.focusedToMeridiem = .pm
        }
      }, label: {
        switch self.focusedFromToEdit {
        case .start:
          ATSelectableButton(
            contentsView: Text(Meridiem.pm.localizedName)
              .font(.fonts(.body14))
              .foregroundStyle(Gen.Colors.white.color),
            isSelected: Binding(get: { self.focusedFromMeridiem == .pm }, set: { _ in })
          ) { isSelected in
              self.focusedFromMeridiem = .pm
          }
        case .end:
          ATSelectableButton(
            contentsView: Text(Meridiem.pm.localizedName)
              .font(.fonts(.body14))
              .foregroundStyle(Gen.Colors.white.color),
            isSelected: Binding(get: { self.focusedToMeridiem == .pm }, set: { _ in })
          ) { isSelected in
            self.focusedToMeridiem = .pm
          }
        }
      })
    }
    
  }
  
  @ViewBuilder
  private func timeFromPickerView() -> some View {
    ATWatchTimeSelectorView(
      selectedHour: Binding(
        get: { Int(self.selectedFromTime.hour) },
        set: { selected in self.selectedFromTime = .init(hour: UInt(selected), minute: 0) }
      ),
      meridiem: self.$focusedFromMeridiem
    )
  }
  
  @ViewBuilder
  private func timeToPickerView() -> some View {
    ATWatchTimeSelectorView(
      selectedHour: Binding(
        get: { Int(self.selectedToTime.hour) },
        set: { selected in self.selectedToTime = .init(hour: UInt(selected), minute: 0) }
      ),
      meridiem: self.$focusedToMeridiem
    )
  }
  
  @ViewBuilder
  private func cancelButton(action: @escaping () -> Void) -> some View {
    Button(action: {
      action()
    }, label: {
      VStack {
        Gen.Images.trash.image
          .resizable()
          .frame(width: 28, height: 28)
      }
      .frame(width: 52, height: 52)
      .background(Gen.Colors.purpleGray500.color)
      .clipShape(.circle)
    })
  }
  
  
  
  // MARK: - internal method
  
}
