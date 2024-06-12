//
//  OnboardingView.swift
//  OnboardingView
//
//  Created by Aaron Hanwe LEE on 1/29/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import ArchiveFoundation
import UIComponents
import AppRoute

public struct OnboardingView: View {
  
  // MARK: - Private Property
  
  private let store: StoreOf<OnboardingReducer>
  
  // MARK: - Internal Property
  
  // MARK: - Life Cycle
  
  public init(
    reducer: OnboardingReducer
  ) {
    self.store = .init(initialState: reducer.initialState, reducer: {
      return reducer
    })
  }
  
  public var body: some View {
    
    WithViewStore(store, observe: { $0 }) { viewStore in
      ZStack {
        ATBackgroundView()
          .ignoresSafeArea(.all)
        VStack {
          Spacer()
          Spacer()
          Spacer()
          
          Gen.Images.logo.image
          
          Spacer()
          Spacer()
          Spacer()
          
          VStack(spacing: 16) {
            ATSignInButton(type: .apple, action: {
              print("1")
            })
            ATSignInButton(type: .google, action: {
              print("2")
            })
            ATSignInButton(type: .facebook, action: {
              print("3")
            })
          }
          .padding(.designContentsSideInsets)
          
          Spacer()
        }
      }
    }
    
  }
  
  // MARK: - Private Method
  
  // MARK: - Internal Method
  
}
