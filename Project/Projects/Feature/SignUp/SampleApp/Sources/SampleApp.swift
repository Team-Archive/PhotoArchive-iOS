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
import AppRoute

@main
struct SampleApp: App {
  var body: some Scene {
    WindowGroup {
      SignUpView<StubPhotoPickerView>(
        reducer: SignUpReducer(
          updateProfileUsecase: UpdateProfileUsecaseImplement(repository: StubUpdateProfileRepositoryImplement()),
          signUpUsecase: SignUpUsecaseImplement(repository: StubSignUpRepositoryImplement()), nicknameMaxLength: 24
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
    return .success(name == "Test")
  }
  
  func updateName(_ name: String) async -> Result<Void, ArchiveError> {
    return .success(())
  }
  
}

final class StubSignUpRepositoryImplement: SignUpRepository {
  
  func signUp(name: String, cityId: String, preferTime: [DaysOfTheWeek: [ActivityTime]]) async -> Result<String, ArchiveError> {
    return .success("token")
  }
  
}

struct StubPhotoPickerView: View, PhotoPicker {
  
  var closeAction: (() -> Void)
  var completeAction: (([PHAsset]) -> Void)
  
  init(
    completeAction: @escaping ([PHAsset]) -> Void,
    closeAction: @escaping () -> Void
  ) {
    self.completeAction = completeAction
    self.closeAction = closeAction
  }
  
  public var body: some View {
    VStack(spacing: 20) {
      Button(action: {
        completeAction([
          MockPHAsset(),
        ])
      }, label: {
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
