//
//  OnboardingReducer.swift
//  Onboarding
//
//  Created by Aaron Hanwe LEE on 6/12/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import ComposableArchitecture
import Foundation
import ArchiveFoundation
import Domain

public struct OnboardingReducer: Reducer {
  
  // MARK: - TCA Define
  
  public enum Action: Equatable {
    case setIsLoading(Bool)
    case setError(ArchiveError)
    case oauthSignIn(OAuthSignInType)
  }
  
  public struct State: Equatable {
    var isLoading: Bool = false
    var err: ArchiveError?
  }
  
  // MARK: - Private Property
  
  // MARK: - Internal Property
  
  var initialState: State
  
  // MARK: - Public Property
  
  // MARK: - LifeCycle
  
  public init(
    
  ) {
    self.initialState = .init()
  }
  
  public var body: some ReducerOf<Self> {
    Reduce {state, action in
      switch action {
      case .setIsLoading(let isLoading):
        state.isLoading = isLoading
        return .none
      case .setError(let err):
        state.err = err
        return .none
      case .oauthSignIn(let type):
        let oauth = OAuthUsecaseFactory.makeOAuthUsecase(type)
        return .concatenate(
          .run(operation: { send in
            await send(.setIsLoading(true))
            let oauthSignInResult = await oauth.oauthSignIn()
            switch oauthSignInResult {
            case .success(let oauthSignInResponseData):
              print("oauth: \(oauthSignInResponseData)")
            case .failure(let err):
              await send(.setError(err))
            }
            await send(.setIsLoading(false))
          })
        )
      }
    }
  }
  
  // MARK: - Private Method
  
  // MARK: - Public Method
  
}

