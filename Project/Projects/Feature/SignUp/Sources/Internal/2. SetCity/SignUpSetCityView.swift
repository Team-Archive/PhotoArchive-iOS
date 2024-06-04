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
          ATBottomActionButton(
            designType: .secondary,
            title: L10n.Localizable.commonNext,
            action: {
              nextAction()
            },
            isEnabled: .constant(true)
          )
        }
      }
    }
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
}
