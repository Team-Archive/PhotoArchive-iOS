//
//  SignUpSetActivityTimeView.swift
//  SignUp
//
//  Created by hanwe on 7/21/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import UIComponents
import ArchiveFoundation
import ComposableArchitecture

struct SignUpSetActivityTimeView: View, SignUpStepView {
  
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
    self.nextAction = nextAction
    self.store = store
  }
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      ZStack {
        Gen.Colors.backgroundSignUp.color
          .ignoresSafeArea(.all)
        VStack {
          ScrollView {
            VStack(spacing: 40) {
              
              VStack(spacing: 8) {
                HStack {
                  Text(L10n.Localizable.signUpSetActivityTimeTitle)
                    .font(.fonts(.title24))
                    .foregroundStyle(Gen.Colors.white.color)
                  Spacer()
                }
                HStack {
                  Text(L10n.Localizable.signUpSetActivityTimeContents)
                    .font(.fonts(.body14))
                    .foregroundStyle(Gen.Colors.gray300.color)
                    .multilineTextAlignment(.leading)
                  Spacer()
                }
              }
              .padding(.top, 28)
              
              VStack(spacing: 0) {
                ForEach(0..<SignUpActivityTime.allCases.count, id: \.self) { index in
                  activityTimeCellView(SignUpActivityTime.allCases[index])
                }
                addCustomView()
              }
              
            }
            .padding(.designContentsSideInsets)
          }
        }
      }
    }
  }
  
  // MARK: - private method
  
  @ViewBuilder
  private func addCustomView() -> some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack {
        ATDivider(type: .small)
        Spacer()
        Button(action: {
          print("다른시간 선택!")
        }, label: {
          HStack(spacing: 4) {
            Text("⏰ " + L10n.Localizable.signUpSetActivityTimeMakeCustomTimeButton)
              .font(.fonts(.buttonSemiBold14))
              .foregroundStyle(Gen.Colors.white.color)
            Gen.Images.arrow.image
              .resizable()
              .frame(width: 16, height: 16)
          }
          .padding(.top, 16)
        })
      }
      .frame(height: 32)
    }
  }
  
  @ViewBuilder
  private func activityTimeCellView(_ item: SignUpActivityTime) -> some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      ZStack {
        VStack {
          ATDivider(type: .small)
          Spacer()
        }
        VStack() {
          HStack(spacing: 4) {
            item.icon
              .resizable()
              .frame(width: 16, height: 16)
            Text(item.localizedName)
              .font(.fonts(.bodyBold16))
              .foregroundStyle(Gen.Colors.white.color)
            Text(item.rawValue.to12HourFormat())
              .font(.fonts(.body12))
              .foregroundStyle(Gen.Colors.purple.color)
            Spacer()
            ATCheckBoxView(
              title: nil,
              isChecked: Binding(get: { viewStore.selectedActivityTime.contains(item) }, set: { _ in }),
              action: { isChecked in
                viewStore.send(.selectActiveTime(
                  willSelected: !isChecked,
                  signUpActivityTime: item
                ))
              }
            )
          }
        }
      }
      .frame(height: 66)
    }
  }
  
  // MARK: - internal method
  
}
