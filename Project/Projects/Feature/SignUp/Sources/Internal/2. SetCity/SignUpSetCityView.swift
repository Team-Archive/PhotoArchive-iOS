//
//  SignUpSetCityView.swift
//  SignUp
//
//  Created by hanwe on 5/25/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import UIComponents
import ArchiveFoundation
import ComposableArchitecture

struct SignUpSetCityView: View, SignUpStepView {
  
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
          HStack {
            Text(L10n.Localizable.signUpSetCityTitle)
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
            Text(L10n.Localizable.signUpSetCityContents)
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
          
          ATUnderlineInputView(
            leftIconImage: Gen.Images.search.image,
            placeholderMessage: L10n.Localizable.signUpSetCitySearchPlaceholder,
            message: Binding(get: { viewStore.searchCityKeyword }, set: { text in viewStore.send(.setSearchCityKeyword(keyword: text)) }),
            isValidMessage: Binding(get: { viewStore.isValidNickname != .invalid(.duplicated) }, set: { _ in }),
            submitLabel: .done,
            maxLength: viewStore.nicknameMaxLength
          )
          .onDebouncedChange(of: viewStore.searchCityKeyword, debounceTime: 0.5, perform: { keyword in
            viewStore.send(.searchCity(keyword: keyword))
          })
          .padding(
            .init(
              top: 32,
              leading: .designContentsInset,
              bottom: 0,
              trailing: .designContentsInset
            )
          )
          
          
        }
      }
    }
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
}
