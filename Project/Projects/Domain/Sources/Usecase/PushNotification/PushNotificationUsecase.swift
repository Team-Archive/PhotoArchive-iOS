//
//  PushNotificationUsecase.swift
//  Domain
//
//  Created by hanwe on 6/23/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import UserNotifications

public protocol PushNotificationUsecase {
  func notificationAuthorizationStatus() async -> UNAuthorizationStatus
}
