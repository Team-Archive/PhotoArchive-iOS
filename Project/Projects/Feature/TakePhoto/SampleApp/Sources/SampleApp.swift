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
