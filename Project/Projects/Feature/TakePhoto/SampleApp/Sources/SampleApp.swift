//
//  App.swift
//  ArchiveFoundation
//
//  Created by hanwe on 1/28/24.
//  Copyright © 2024 Archive. All rights reserved.
//

import SwiftUI
import TakePhoto
import Domain

@main
struct SampleApp: App {
  var body: some Scene {
    WindowGroup {
      TakePhotoView(
        reducer: TakePhotoReducer(
          cameraUsecase: CameraUsecaseImplement(
            repository: StubCameraRepositoryImplement()
          )
        )
      )
    }
  }
}

final class StubCameraRepositoryImplement: CameraRepository {
  func startSession() {
    print("start session")
  }
  
  func stopSession() {
    print("stop session")
  }
  
  func takePhoto() async -> Data? {
    print("take photo")
    return nil
  }
  
  func switchCamera() {
    print("switch camera")
  }
  
  
}
