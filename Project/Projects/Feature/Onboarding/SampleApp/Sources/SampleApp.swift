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

@main
struct SampleApp: App {
  var body: some Scene {
    WindowGroup {
      OnboardingView<StubSignUpView>(
        reducer: OnboardingReducer(
          signInUsecase: SignInUsecaseImplement(
            repository: StubSignInRepositoryImplement()
          ), 
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

class StubSignInRepositoryImplement: SignInRepository {
  
  func signIn(_ oauthSignInData: OAuthSignInData) async -> Result<ServiceSignInResponse, ArchiveError> {
    return .success(
      .notServiceUser
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
