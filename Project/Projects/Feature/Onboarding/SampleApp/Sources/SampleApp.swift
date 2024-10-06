//
//  App.swift
//  ArchiveFoundation
//
//  Created by hanwe on 1/28/24.
//  Copyright © 2024 Archive. All rights reserved.
//

import SwiftUI
import Onboarding
import Domain
import ArchiveFoundation
import AppRoute
import DomainInterface

@main
struct SampleApp: App {
  var body: some Scene {
    WindowGroup {
      OnboardingView<StubSignUpView>(
        reducer: OnboardingReducer(
          signInUsecase: SignInUsecaseImplement(
            repository: StubSignInRepositoryImplement()
          ), 
          oauthUsecaseFactory: StubOAuthUsecaseFactory(),
          pushNotificationUsecase: PushNotificationUsecaseImplement(
            repository: StubPushNotificationRepositoryImplement()
          ),
          signInServiceComplete: { token in
            print("로그인 완료: \(token)")
          }
        )
      )
    }
  }
}

class StubOAuthUsecaseFactory: OAuthUsecaseFactory {
  func oauthSignIn(type: OAuthProvider) async -> Result<OAuthSignInData, ArchiveError> {
    switch type {
    case .apple:
      return .success(.apple(token: "123"))
    case .facebook:
      return .success(.facebook(token: "456"))
    case .google:
      return .success(.google(token: "789"))
    }
  }
}

class StubSignInRepositoryImplement: SignInRepository {
  
  func signIn(_ oauthSignInData: OAuthSignInData) async -> Result<ServiceSignInResponse, ArchiveError> {
    return .success(
      .user(.init(accessToken: "123", refreshToken: "456"))
    )
  }
  
}

struct StubSignUpView: View, ServiceSignInDelegator {
  
  var closeAction: (() -> Void)
  var completeAction: ((SignInToken) -> Void)
  
  init(
    completeAction: @escaping (SignInToken) -> Void,
    closeAction: @escaping () -> Void
  ) {
    self.completeAction = completeAction
    self.closeAction = closeAction
  }
  
  public var body: some View {
    VStack(spacing: 20) {
      VStack {
        Text("This is Stub SignUp")
      }
      Button(action: {
        closeAction()
      }, label: {
        Text("This is close action")
      })
    }
  }
  
}

public final class StubPushNotificationRepositoryImplement: PushNotificationRepository {
  public init() {
    
  }
}
