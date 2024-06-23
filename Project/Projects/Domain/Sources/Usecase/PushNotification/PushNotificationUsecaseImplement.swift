//
//  PushNotificationUsecaseImplement.swift
//  Domain
//
//  Created by hanwe on 6/23/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import UserNotifications

public final class PushNotificationUsecaseImplement: PushNotificationUsecase {
  
  // MARK: - private property
  
  private let repository: PushNotificationRepository
  
  // MARK: - internal property
  
  // MARK: - lifeCycle
  
  public init(repository: PushNotificationRepository) {
    self.repository = repository
  }
  
  // MARK: - private method
  
  // MARK: - public method
  
  public func notificationAuthorizationStatus() async -> UNAuthorizationStatus {
    let settings = await UNUserNotificationCenter.current().notificationSettings()
    return settings.authorizationStatus
  }
  
}
