//
//  SignUpStepFactory.swift
//  SignUp
//
//  Created by Aaron Hanwe LEE on 6/3/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import AppRoute

enum SignUpStep: Int, CaseIterable, Hashable {
  case setProfile
  case setCity
  case setActivityTime
}

struct SignUpStepFactory<PhotoPickerView> where PhotoPickerView: PhotoPicker {
  
  // MARK: - private properties
  
  private let store: StoreOf<SignUpReducer>
  
  // MARK: - internal properties
  
  // MARK: - life cycle
  
  init(
    store: StoreOf<SignUpReducer>
  ) {
    self.store = store
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
  @ViewBuilder
  func stepView(step: SignUpStep, nextAction: @escaping () -> Void) -> some View {
    switch step {
    case .setProfile:
      SignUpSetProfileView<PhotoPickerView>(
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
