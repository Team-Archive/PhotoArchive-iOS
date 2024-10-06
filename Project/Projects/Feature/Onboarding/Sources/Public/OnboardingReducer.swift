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
import UserNotifications
import DomainInterface

public struct OnboardingReducer: Reducer {
  
  // MARK: - TCA Define
  
  public enum Action: Equatable {
    case action(ViewAction)
    case mutate(Mutation)
  }
  
  public enum ViewAction: Equatable {
    case oauthSignIn(OAuthProvider)
    case setServiceSignInToken(SignInToken)
    case closeSignUp
    case closeTerms
    case agreeAllTerms
    case doneNotificationAgree
  }
  
  public enum Mutation: Equatable {
    case setIsLoading(Bool)
    case setError(ArchiveError?)
    case setIsShowSignUp(Bool)
    case setIsShowTerms(Bool)
    case setIsAllTermsAgree(Bool)
  }
  
  public struct State: Equatable {
    var isLoading: Bool = false
    var err: ArchiveError?
    var isShowTerms: Bool = false
    var isAllTermsAgree: Bool = false
    var isShowSignUp: Bool = false
    var notificationStatus: UNAuthorizationStatus = .notDetermined
  }
  
  // MARK: - Private Property
  
  private let signInUsecase: SignInUsecase
  private let oauthUsecaseFactory: OAuthUsecaseFactory
  private let signInServiceComplete: (SignInToken) -> Void
  private let pushNotificationUsecase: PushNotificationUsecase
  
  // MARK: - Internal Property
  
  var initialState: State
  
  // MARK: - Public Property
  
  // MARK: - LifeCycle
  
  public init(
    signInUsecase: SignInUsecase,
    oauthUsecaseFactory: OAuthUsecaseFactory,
    pushNotificationUsecase: PushNotificationUsecase,
    signInServiceComplete: @escaping (SignInToken) -> Void
  ) {
    self.initialState = .init()
    self.signInUsecase = signInUsecase
    self.oauthUsecaseFactory = oauthUsecaseFactory
    self.pushNotificationUsecase = pushNotificationUsecase
    self.signInServiceComplete = signInServiceComplete
  }
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .action(let action):
        switch action {
        case .oauthSignIn(let type):
          return .concatenate(
            .run(operation: { send in
              let oauthSignInResult = await self.oauthUsecaseFactory.oauthSignIn(type: type)
              switch oauthSignInResult {
              case .success(let oauthSignInResponseData):
                await send(.mutate(.setIsLoading(true)))
                let signInServieResult = await self.signInService(oauthSignInResponseData)
                switch signInServieResult {
                case .success(let serviceSignInResult):
                  switch serviceSignInResult {
                  case .notServiceUser:
                    await send(.mutate(.setIsShowTerms(true)))
                  case .user(let token):
                    print("토큰: \(token)")
                  }
                case .failure(let err):
                  await send(.mutate(.setError(err)))
                }
                await send(.mutate(.setIsLoading(false)))
              case .failure(let err):
                await send(.mutate(.setError(err)))
              }
            })
          )
        case .setServiceSignInToken(let token):
          print("token~~: \(token)")
          return .none
        case .closeSignUp:
          return .run { send in
            await send(.mutate(.setIsShowSignUp(false)))
          }
        case .closeTerms:
          return .run { send in
            await send(.mutate(.setIsShowTerms(false)))
          }
        case .agreeAllTerms:
          return .concatenate(
            .run { send in
              await send(.mutate(.setIsAllTermsAgree(true)))
              await send(.mutate(.setIsShowTerms(false)))
            }
          )
        case .doneNotificationAgree:
          return .run { send in
            await send(.mutate(.setIsShowSignUp(true)))
          }
        }
      case .mutate(let mutation):
        switch mutation {
        case .setIsLoading(let isLoading):
          state.isLoading = isLoading
          return .none
        case .setError(let err):
          state.err = err
          return .none
        case .setIsShowSignUp(let isShow):
          state.isShowSignUp = isShow
          return .none
        case .setIsShowTerms(let isShow):
          state.isShowTerms = isShow
          return .none
        case .setIsAllTermsAgree(let isShow):
          state.isAllTermsAgree = isShow
          return .none
        }
      }
    }
  }
  
  // MARK: - Private Method
  
  private func signInService(_ oauthSignInData: OAuthSignInData) async -> Result<ServiceSignInResponse, ArchiveError> {
    return await self.signInUsecase.signIn(oauthSignInData)
  }
  
  private func notificationAuthorizationStatus() async -> UNAuthorizationStatus {
    return await self.pushNotificationUsecase.notificationAuthorizationStatus()
  }
  
  // MARK: - Public Method
  
}

