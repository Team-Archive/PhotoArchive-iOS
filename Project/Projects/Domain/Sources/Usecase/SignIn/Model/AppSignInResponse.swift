//
//  AppSignInResponse.swift
//  Domain
//
//  Created by Aaron Hanwe LEE on 6/12/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import ArchiveFoundation
import Foundation

public enum ServiceSignInResponse {
  case user(SignInToken)
  case notServiceUser
}
