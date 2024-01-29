//
//  SignUpUsecaseInterface.swift
//  SignUp
//
//  Created by Aaron Hanwe LEE on 1/29/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation

public protocol SignUpUsecaseInterface {
  
  static func makeObject() -> SignUpUsecaseInterface
  
  func signUp()
  
}
