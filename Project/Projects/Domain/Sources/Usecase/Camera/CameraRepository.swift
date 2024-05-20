//
//  CameraRepository.swift
//  Domain
//
//  Created by hanwe on 5/19/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import AVFoundation

public protocol CameraRepository {
  
  var session: AVCaptureSession { get }
  
  func startSession()
  func stopSession()
  func takePhoto() async -> Data?
  func switchCamera()
}
