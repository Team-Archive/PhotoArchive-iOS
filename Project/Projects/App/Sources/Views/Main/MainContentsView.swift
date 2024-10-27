//
//  MainContentsView.swift
//  App
//
//  Created by hanwe on 10/20/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import ArchiveFoundation
import UIComponents
import Onboarding
import Domain
import AppRoute
import DomainInterface
import Data

public struct MainContentView: View {
  
  // MARK: - Private Property
  
  @State private var store: StoreOf<MainReducer>
  
  // MARK: - Internal Property
  
  // MARK: - Life Cycle
  
  public init(
    reducer: MainReducer
  ) {
    self._store = .init(wrappedValue: .init(initialState: reducer.initialState, reducer: {
      return reducer
    }))
  }
  
  public var body: some View {
    
    WithViewStore(store, observe: { $0 }) { viewStore in
      
      ZStack {
        if viewStore.state.isLoggedIn {
          Text("로그인이 되었어요!")
        } else {
          OnboardingView<SignUpWrapperView>(
            reducer: OnboardingReducer(
              signInUsecase: SignInUsecaseImplement(
                repository: SignInRepositoryImplement()
              ),
              oauthUsecaseFactory: OAuthUsecaseFactoryImplement(
                signInWithApple: StubOAtuh(),
                signInWithGoogle: StubOAtuh(),
                signInWithFacebook: StubOAtuh()
              ),
              pushNotificationUsecase: PushNotificationUsecaseImplement(
                repository: PushNotificationRepositoryImplement()
              ),
              signInTokenManager: SignInManagerImplement.shared
            )
          )
        }
      }
      .onAppear {
        viewStore.send(.action(.bindingLoginStatus))
      }
      
    }
    
  }
  
  // MARK: - Private Method
  
  // MARK: - Internal Method
  
}

fileprivate class StubOAtuh: OAuth {
  func oauthSignIn() async -> Result<OAuthSignInData, ArchiveError> {
    // TODO: 구현
    return .failure(.init(.commonError))
  }
}
