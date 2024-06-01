//
//  CoordinatorRoute.swift
//  AppRoute
//
//  Created by Aaron Hanwe LEE on 5/20/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import Domain
import Photos

public enum CoordinatorRoute {
  
  case albumIsRequired
  case albumIsComplete([PHAsset])
  
}
