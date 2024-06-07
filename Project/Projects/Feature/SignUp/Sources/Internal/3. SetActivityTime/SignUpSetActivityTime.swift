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
      ZStack {
        
      }
    }
    
  }
  
  // MARK: - internal method
  
}
