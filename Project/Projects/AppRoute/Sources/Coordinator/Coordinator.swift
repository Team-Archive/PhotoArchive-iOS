//
//  Coordinator.swift
//  AppRoute
//
//  Created by Aaron Hanwe LEE on 5/20/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI

public protocol Coordinator: AnyObject {
  var parentsCoordinator: Coordinator? { get }
  
  func navigate(to: CoordinatorRoute)
}
