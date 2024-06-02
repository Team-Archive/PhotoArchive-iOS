//
//  App.swift
//  ArchiveFoundation
//
//  Created by hanwe on 1/28/24.
//  Copyright © 2024 Archive. All rights reserved.
//

import SwiftUI
import SignUp
import Domain
import ArchiveFoundation
import Photos

@main
struct SampleApp: App {
  var body: some Scene {
    WindowGroup {
      SignUpView(
        reducer: SignUpReducer(
          updateProfileUsecase: UpdateProfileUsecaseImplement(repository: StubUpdateProfileRepositoryImplement()),
          signUpUsecase: SignUpUsecaseImplement(repository: StubSignUpRepositoryImplement())
        )
      )
    }
  }
}

final class StubUpdateProfileRepositoryImplement: UpdateProfileRepository {
  
  func updateProfilePhoto(asset: PHAsset) async -> Result<Void, ArchiveError> {
    return .success(())
  }
  
  func isDuplicatedName(_ name: String) async -> Result<Bool, ArchiveError> {
    return .success(name == "test")
  }
  
  func updateName(_ name: String) async -> Result<Void, ArchiveError> {
    return .success(())
  }
  
}

final class StubSignUpRepositoryImplement: SignUpRepository {
  
  func signUp(name: String, cityId: String, preferTime: [DaysOfTheWeek : [ActivityTime]]) async -> Result<String, ArchiveError> {
    return .success("token")
  }
  
}


