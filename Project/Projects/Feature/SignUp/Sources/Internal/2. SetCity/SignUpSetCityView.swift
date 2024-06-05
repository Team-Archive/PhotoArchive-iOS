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
            submitLabel: .search,
            maxLength: .max
          )
          .onDebouncedChange(of: viewStore.searchCityKeyword, debounceTime: 0.5, perform: { keyword in
            viewStore.send(.searchCity(keyword: keyword))
          })
          .padding(
            .init(
              top: 12,
              leading: .designContentsInset,
              bottom: 0,
              trailing: .designContentsInset
            )
          )
          
          SearchContentsView()
            .padding(
            .init(
              top: 0,
              leading: .designContentsInset,
              bottom: 0,
              trailing: .designContentsInset
            )
          )
          
        }
      }
      .onAppear {
        viewStore.send(.searchCity(keyword: ""))
      }
    }
  }
  
  // MARK: - private method
  
  @ViewBuilder
  private func SearchContentsView() -> some View {
    
    WithViewStore(store, observe: { $0 }) { viewStore in
      ZStack {
        if viewStore.candidateCityList.count > 0 {
          ScrollView {
            let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 0), count: 1)
            LazyVGrid(columns: columns, spacing: 20) {
              ForEach(0..<viewStore.candidateCityList.count, id: \.self) { index in
                if let city: City = viewStore.candidateCityList[safe: index] {
                  CityCell(info: city, index: UInt(index))
                    .id(city.id)
                    .onAppear {
                      if index == viewStore.candidateCityList.count - 1 {
                        viewStore.send(.moreSearchCity)
                      }
                    }
                }
              }
            }
            .padding(.top, 20)
          }
        } else {
          EmptyResultView()
        }
        if viewStore.isLoading {
          ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: Gen.Colors.white.color))
            .scaleEffect(1.5)
        }
      }
      
    }
    
  }
  
  @ViewBuilder
  private func CityCell(info city: City, index: UInt) -> some View {
    
    WithViewStore(store, observe: { $0 }) { viewStore in
      Button(action: {
        viewStore.send(.setSelectedCity(city))
        self.nextAction()
      }, label: {
        HStack(spacing: 0) {
          Text(city.country.emoji)
          Text("\(city.name), \(city.country.name)")
            .font(.fonts(.body14))
            .foregroundStyle(Gen.Colors.white.color)
          Spacer()
        }
      })
    }
    
  }
  
  @ViewBuilder
  private func EmptyResultView() -> some View {
    VStack(spacing: 12) {
      Spacer()
      Text(L10n.Localizable.signUpSetCitySearchNoResultTitle)
        .font(.fonts(.body16))
        .foregroundStyle(Gen.Colors.white.color)
        .multilineTextAlignment(.center)
      Text(L10n.Localizable.signUpSetCitySearchNoResultContents)
        .font(.fonts(.body14))
        .foregroundStyle(Gen.Colors.white.color)
        .multilineTextAlignment(.center)
      Spacer()
      Spacer()
      Spacer()
    }
  }
  
  // MARK: - internal method
  
}
