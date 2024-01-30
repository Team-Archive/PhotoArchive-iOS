//
//  SignInUsecaseInterface.swift
//  SignIn
//
//  Created by Aaron Hanwe LEE on 1/29/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation

public protocol SignInUsecaseInterface {
  
  static func makeObject() -> SignInUsecaseInterface
  
  func signIn()
  
}
