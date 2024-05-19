//
//  CameraRepository.swift
//  Domain
//
//  Created by hanwe on 5/19/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation

public protocol CameraRepository {
  func startSession()
  func stopSession()
  func takePhoto() async -> Data?
  func switchCamera()
}
