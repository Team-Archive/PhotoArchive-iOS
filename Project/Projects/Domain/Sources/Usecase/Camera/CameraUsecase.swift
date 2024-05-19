//
//  CameraUsecase.swift
//  Domain
//
//  Created by hanwe on 5/19/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import ArchiveFoundation
import AVFoundation

public protocol CameraUsecase {
  func checkCameraAuthorization() async -> AVAuthorizationStatus
}
