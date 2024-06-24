//
//  SignUpView.swift
//  SignUp
//
//  Created by hanwe on 5/25/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import ArchiveFoundation
import UIComponents
import AppRoute

public struct SignUpView<PhotoPickerView>: View where PhotoPickerView: PhotoPicker {
  
  // MARK: - Private Property
  
  private let store: StoreOf<SignUpReducer>
  private lazy var signUpStepFactory: SignUpStepFactory<PhotoPickerView> = .init(store: self.store)
  @State private var stackPath: NavigationPath = .init()
  
  // MARK: - Internal Property
  
  // MARK: - Life Cycle
  
  public init(
    reducer: SignUpReducer
  ) {
    self.store = .init(initialState: reducer.initialState, reducer: {
      return reducer
    })
  }
  
  public var body: some View {
    
    WithViewStore(store, observe: { $0 }) { viewStore in
      ZStack {
        Gen.Colors.backgroundSignUp.color
          .ignoresSafeArea(.all)
        VStack(spacing: 0) {
          SignUpFakeNavigationView(
            path: self.$stackPath,
            requestBackAction: {
              if self.stackPath.count > 0 {
                self.stackPath.removeLast()
              }
          })
          .frame(height: 56)
          SignUpProgressView(path: self.$stackPath)
            .frame(height: 4)
          NavigationStack(path: $stackPath) {
            SignUpStepFactory<PhotoPickerView>(store: store).stepView(step: SignUpStep.allCases.first ?? .setProfile, nextAction: {
              stackPath.append(SignUpStep.setCity)
            })
            .navigationDestination(for: SignUpStep.self) { step in
              SignUpStepFactory<PhotoPickerView>(store: store).stepView(step: step, nextAction: {
                if let nextStep = SignUpStep(rawValue: step.rawValue + 1) {
                  stackPath.append(nextStep)
                } else {
                  viewStore.send(.signUp)
                }
              })
            }
          }
        }
      }
    }
    
  }
  
  // MARK: - Private Method
  
  // MARK: - Internal Method
  
}
