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
              viewStore.send(.oauthSignIn(.apple))
            })
            ATSignInButton(type: .google, action: {
              viewStore.send(.oauthSignIn(.google))
            })
            ATSignInButton(type: .facebook, action: {
              viewStore.send(.oauthSignIn(.facebook))
            })
          }
          .padding(.designContentsSideInsets)
          
          Spacer()
        }
        
        if viewStore.isLoading {
          ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: Gen.Colors.white.color))
            .scaleEffect(1.5)
        }
      }
    }
    
  }
  
  // MARK: - Private Method
  
  // MARK: - Internal Method
  
}
