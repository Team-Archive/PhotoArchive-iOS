//
//  SignUpWrapperView.swift
//  App
//
//  Created by hanwe on 10/20/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import AppRoute
import SignUp
import Domain
import Data
import DomainInterface
import ArchiveFoundation

public struct SignUpWrapperView: View, ServiceSignInDelegator {
  
  
  // MARK: - Private Property
  
  let hostView: SignUpView<PhotoPickerWrapperView>
  
  // MARK: - Internal Property
  
  // MARK: - Life Cycle
  
  public init(
    oauthSignInData: OAuthSignInData,
    completeAction: @escaping (SignInToken) -> Void,
    closeAction: @escaping () -> Void
  ) {
    self.hostView = SignUpView(
      reducer: SignUpReducer(
        updateProfileUsecase: UpdateProfileUsecaseImplement(
          repository: UpdateProfileRepositoryImplement()
        ),
        signUpUsecase: SignUpUsecaseImplement(
          repository: SignUpRepositoryImplement()
        ),
        cityInfoUsecase: CityInfoUsecaseImplement(
          repository: CityInfoRepositoryImplement()
        ),
        nicknameMaxLength: 10,
        oauthSignInData: oauthSignInData,
        completion: { token in
          completeAction(token)
        }
      )
    )
  }
  
  public var body: some View {
    hostView
  }
  
  // MARK: - Private Method
  
  // MARK: - Internal Method
  
}
