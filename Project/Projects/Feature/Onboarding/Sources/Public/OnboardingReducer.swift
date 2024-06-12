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
    case setIsShowTerms(Bool)
    case setIsShowNotificationAgree(Bool)
    case signInService(SignInToken)
    case agreeAllTerms
    case doneNotificationAgree
    case setIsShowSignUp(Bool)
  }
  
  public struct State: Equatable {
    var isLoading: Bool = false
    var err: ArchiveError?
    var isShowTerms: Bool = false
    var isShowNotificationAgree: Bool = false
    var isShowSignUp: Bool = false
  }
  
  // MARK: - Private Property
  
  private let signInUsecase: SignInUsecase
  private let signInServiceComplete: (SignInToken) -> Void
  
  // MARK: - Internal Property
  
  var initialState: State
  
  // MARK: - Public Property
  
  // MARK: - LifeCycle
  
  public init(
    signInUsecase: SignInUsecase,
    signInServiceComplete: @escaping (SignInToken) -> Void
  ) {
    self.initialState = .init()
    self.signInUsecase = signInUsecase
    self.signInServiceComplete = signInServiceComplete
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
              let signInServieResult = await self.signInService(oauthSignInResponseData)
              switch signInServieResult {
              case .success(let serviceSignInResponse):
                switch serviceSignInResponse {
                case .user(let token):
                  self.signInServiceComplete(token)
                case .notServiceUser:
                  await send(.setIsShowTerms(true))
                }
              case .failure(let err):
                await send(.setError(err))
              }
            case .failure(let err):
              await send(.setError(err))
            }
            await send(.setIsLoading(false))
          })
        )
      case .setIsShowTerms(let isShow):
        state.isShowTerms = isShow
        return .none
      case .setIsShowNotificationAgree(let isShow):
        state.isShowNotificationAgree = isShow
        return .none
      case .signInService(let token):
        self.signInServiceComplete(token)
        return .none
      case .agreeAllTerms:
        return .concatenate(
          .run(operation: { send in
            await send(.setIsShowTerms(false))
            await send(.setIsShowNotificationAgree(true))
          })
        )
      case .doneNotificationAgree:
        return .concatenate(
          .run(operation: { send in
            await send(.setIsShowNotificationAgree(false))
            await send(.setIsShowSignUp(true))
          })
        )
      case .setIsShowSignUp(let isShow):
        state.isShowSignUp = isShow
        return .none
      }
    }
  }
  
  // MARK: - Private Method
  
  private func signInService(_ oauthSignInData: OAuthSignInData) async -> Result<ServiceSignInResponse, ArchiveError> {
    return await self.signInUsecase.signIn(oauthSignInData)
  }
  
  // MARK: - Public Method
  
}

