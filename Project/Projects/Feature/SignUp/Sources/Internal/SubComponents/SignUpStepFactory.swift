//
//  SignUpStepFactory.swift
//  SignUp
//
//  Created by Aaron Hanwe LEE on 6/3/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

enum SignUpStep: Int, CaseIterable, Hashable {
  case setProfile
  case setCity
  case setActivityTime
}

struct SignUpStepFactory {
  
  // MARK: - private properties
  
  private let store: StoreOf<SignUpReducer>
  
  // MARK: - internal properties
  
  // MARK: - life cycle
  
  init(
    store: StoreOf<SignUpReducer>
  ) { // 사진 선택 뷰 받아야할듯
    self.store = store
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
  @ViewBuilder
  func stepView(step: SignUpStep, nextAction: @escaping () -> Void) -> some View {
    switch step {
    case .setProfile:
      SignUpSetProfileView(
        store: self.store,
        nextAction: nextAction
      )
      .toolbar(.hidden)
    case .setCity:
      SignUpSetCityView(
        store: self.store,
        nextAction: nextAction
      )
      .toolbar(.hidden)
    case .setActivityTime:
      SignUpSetActivityTime(
        store: self.store,
        nextAction: nextAction
      )
      .toolbar(.hidden)
    }
  }
  
}
