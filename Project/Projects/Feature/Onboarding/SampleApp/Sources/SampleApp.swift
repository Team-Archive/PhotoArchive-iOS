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
      OnboardingView<StubPhotoPickerView>(
        reducer: OnboardingReducer(
          signInUsecase: SignInUsecaseImplement(
            repository: StubSignInRepositoryImplement()
          ), signInServiceComplete: { token in
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

struct StubPhotoPickerView: View, ServiceSignInDelegator {
  
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
      Button(action: {
        completeAction(
          .init(
            accessToken: "1",
            refreshToken: "2"
          )
        )
      },
             label: {
        VStack {
          Text("This is StubPhotoPickerView")
          Text("Click here")
        }
      })
      Button(action: {
        closeAction()
      }, label: {
        Text("This is close action")
      })
    }
  }
  
}
