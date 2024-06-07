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
import AVFoundation
import AppRoute
import Photos
import ArchiveFoundation

@main
struct SampleApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}

struct ContentView: View {
  @State private var stackPath: NavigationPath = NavigationPath()

  var body: some View {
    NavigationStack(path: $stackPath) {
      VStack {
        Button(action: {
          self.stackPath.append("Detail View")
        }, label: {
          Text("테스트")
        })
      }
      .navigationTitle("테스트입니다.")
      .toolbarTitleDisplayMode(.inline)
      .navigationDestination(for: String.self) { value in
        TakePhotoView<StubPhotoPickerView>(
          reducer: TakePhotoReducer(
            myInfo: StubMyInfo(),
            cameraUsecase: CameraUsecaseImplement(
              repository: StubCameraRepositoryImplement()
            ),
            postingUsecase: StubPostingUsecaseImplement(),
            maxTextInputCount: 10
          ),
          path: $stackPath, 
          completePostAction: {
            print("업로드 완료")
          }
        )
      }
    }
  }
}

struct StubMyInfo: MyInformation {
  var signInToken: SignInToken = .init(accessToken: "abc", refreshToken: "ddd")
  var friendsList: [UserInformation] = [
    .init(
      id: "1",
      name: "Leonardo Williams",
      profileSmallUrl: URL(string: "https://plus.unsplash.com/premium_photo-1674777843203-da3ebb9fbca0/?w=500&h=500"),
      profileUrl: URL(string: "https://plus.unsplash.com/premium_photo-1674777843203-da3ebb9fbca0/?w=500&h=500")
    ),
    .init(
      id: "2",
      name: "Grace Phillips",
      profileSmallUrl: URL(string: "https://images.unsplash.com/photo-1525134479668-1bee5c7c6845?w=500&h=500"),
      profileUrl: URL(string: "https://images.unsplash.com/photo-1525134479668-1bee5c7c6845?w=500&h=500")
    ),
    .init(
      id: "3",
      name: "John Ruiz",
      profileSmallUrl: URL(string: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500&h=500"),
      profileUrl: URL(string: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500&h=500")
    ),
    .init(
      id: "4",
      name: "Savannah Reyes",
      profileSmallUrl: URL(string: "https://plus.unsplash.com/premium_photo-1673512198690-6439132f3187?w=500&h=500"),
      profileUrl: URL(string: "https://plus.unsplash.com/premium_photo-1673512198690-6439132f3187?w=500&h=500")
    ),
    .init(
      id: "5",
      name: "Sofia Chavez",
      profileSmallUrl: URL(string: "https://images.unsplash.com/photo-1606122017369-d782bbb78f32?w=500&h=500"),
      profileUrl: URL(string: "https://images.unsplash.com/photo-1606122017369-d782bbb78f32?w=500&h=500")
    ),
    .init(
      id: "6",
      name: "Christian Cruz",
      profileSmallUrl: URL(string: "https://images.unsplash.com/photo-1528892952291-009c663ce843?w=500&h=500"),
      profileUrl: URL(string: "https://images.unsplash.com/photo-1528892952291-009c663ce843?w=500&h=500")
    ),
    .init(
      id: "7",
      name: "Aurora Reyes",
      profileSmallUrl: URL(string: "https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500&h=500"),
      profileUrl: URL(string: "https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=500&h=500")
    ),
    .init(
      id: "8",
      name: "Jaxon Lee",
      profileSmallUrl: nil,
      profileUrl: nil
    ),
    .init(
      id: "9",
      name: "John Cruz",
      profileSmallUrl: URL(string: "https://images.unsplash.com/photo-1570158268183-d296b2892211?w=500&h=500"),
      profileUrl: URL(string: "https://images.unsplash.com/photo-1570158268183-d296b2892211?w=500&h=500")
    ),
    .init(
      id: "10",
      name: "Scarlett Anderson",
      profileSmallUrl: URL(string: "https://images.unsplash.com/photo-1558507652-2d9626c4e67a?w=500&h=500"),
      profileUrl: URL(string: "https://images.unsplash.com/photo-1558507652-2d9626c4e67a?w=500&h=500")
    ),
    .init(
      id: "11",
      name: "Brenda C. Meyer",
      profileSmallUrl: URL(string: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500&h=500"),
      profileUrl: URL(string: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500&h=500")
    ),
    .init(
      id: "12",
      name: "John Wright",
      profileSmallUrl: URL(string: "https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=500&h=500"),
      profileUrl: URL(string: "https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=500&h=500")
    ),
    .init(
      id: "13",
      name: "Alice Thompson",
      profileSmallUrl: URL(string: "https://plus.unsplash.com/premium_photo-1670588775983-666b23590ffc?w=500&h=500"),
      profileUrl: URL(string: "https://plus.unsplash.com/premium_photo-1670588775983-666b23590ffc?w=500&h=500")
    ),
    .init(
      id: "14",
      name: "Olivia Morales",
      profileSmallUrl: URL(string: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500&h=500"),
      profileUrl: URL(string: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500&h=500")
    ),
    .init(
      id: "15",
      name: "Ezekiel Gonzalez",
      profileSmallUrl: URL(string: "https://plus.unsplash.com/premium_photo-1675129779554-dc86569708c8?w=500&h=500"),
      profileUrl: URL(string: "https://plus.unsplash.com/premium_photo-1675129779554-dc86569708c8?w=500&h=500")
    ),
    .init(
      id: "16",
      name: "Benjamin Kim",
      profileSmallUrl: URL(string: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=500&h=500"),
      profileUrl: URL(string: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=500&h=500")
    ),
    .init(
      id: "17",
      name: "Hudson Cox",
      profileSmallUrl: URL(string: "https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=500&h=500"),
      profileUrl: URL(string: "https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=500&h=500")
    )
  ]
  
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
          MockPHAsset(),
          MockPHAsset(),
          MockPHAsset(),
          MockPHAsset(),
          MockPHAsset(),
          MockPHAsset(),
          MockPHAsset(),
          MockPHAsset(),
          MockPHAsset()
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

final class StubPostingUsecaseImplement: PostingUsecase {
  
  func isValidContents(contents: String?) -> Bool {
    if let contents {
      return !(contents.count > 10)
    } else {
      return true
    }
  }
  
  func post(signInToken: SignInToken, itemList: [PostingItem], toUserIdList: [String]) async -> Result<Void, ArchiveError> {
    
    try? await Task.sleep(nanoseconds: 3 * 1_000_000_000)
    print("보냈다..")
    
    return .success(())
  }
  
  func assetListToImageDataList(assetList: [PHAsset]) async -> Result<[Data], ArchiveError> {
    return .success(assetList.map { _ in .init() })
  }
  
}

#if targetEnvironment(simulator)
import UIKit

final class StubCameraRepositoryImplement: NSObject, CameraRepository {
  
  // MARK: - private properties
  
  // MARK: - internal properties
  
  var session: AVCaptureSession = .init()
  
  // MARK: - life cycle
  
  // MARK: - private method
  
  // MARK: - internal method
  
  func startSession() {
    print("startSession")
  }
  
  func stopSession() {
    print("stopSession")
  }
  
  func takePhoto() async -> Data? {
    let sampleImage = UIImage(systemName: "camera")
    let imageData = sampleImage?.jpegData(compressionQuality: 1.0)
    return imageData
  }
  
  func switchCamera() {
    print("switchCamera")
  }
  
}

#else

final class StubCameraRepositoryImplement: NSObject, CameraRepository {
  
  // MARK: private property
                             
  private var photoOutput = AVCapturePhotoOutput()
  private let sessionQueue = DispatchQueue(label: "cameraSessionQueue")
  private var continuation: CheckedContinuation<Data?, Never>?
  
  // MARK: public property
  
  public var session: AVCaptureSession = AVCaptureSession()
  @Published var isSessionRunning = false
  
  // MARK: lifeCycle
  
  override init() {
    super.init()
    configureSession()
  }
  
  // MARK: private function
  
  private func configureSession() {
    self.session.beginConfiguration()
    self.session.sessionPreset = .photo
    
    guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
          let input = try? AVCaptureDeviceInput(device: camera),
          self.session.canAddInput(input),
          self.session.canAddOutput(self.photoOutput) else {
      print("Failed to set up device input or output")
      return
    }
    
    self.session.addInput(input)
    self.session.addOutput(self.photoOutput)
    self.session.commitConfiguration()
  }
  
  private func camera(_ position: AVCaptureDevice.Position) -> AVCaptureDevice? {
    return AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: position)
  }
  
  // MARK: public function
  
  public func startSession() {
    if !isSessionRunning {
      sessionQueue.async {
        self.session.startRunning()
        DispatchQueue.main.async {
          self.isSessionRunning = true
        }
      }
    }
  }
  
  public func stopSession() {
    if isSessionRunning {
      sessionQueue.async {
        self.session.stopRunning()
        DispatchQueue.main.async {
          self.isSessionRunning = false
        }
      }
    }
  }
  
  public func takePhoto() async -> Data? {
    let settings = AVCapturePhotoSettings()
    
    return await withCheckedContinuation { [weak self] continuation in
      self?.continuation = continuation
      self?.photoOutput.capturePhoto(with: settings, delegate: self ?? StubCameraRepositoryImplement())
    }
  }
  
  public func switchCamera() {
    sessionQueue.async {
      self.session.beginConfiguration()
      guard let currentInput = self.session.inputs.first as? AVCaptureDeviceInput else { return }
      self.session.removeInput(currentInput)
      
      guard let camera = currentInput.device.position == .back ? self.camera(.front) : self.camera(.back) else { print("카메라 이상함;;") ; return }
      guard let newInput = try? AVCaptureDeviceInput(device: camera),
            self.session.canAddInput(newInput) else { return }
      
      self.session.addInput(newInput)
      self.session.commitConfiguration()
    }
  }
  
}

extension StubCameraRepositoryImplement: AVCapturePhotoCaptureDelegate {
  func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
    guard let imageData = photo.fileDataRepresentation() else {
      self.continuation?.resume(returning: nil)
      return
    }
    
    self.continuation?.resume(returning: imageData)
  }
}

#endif


