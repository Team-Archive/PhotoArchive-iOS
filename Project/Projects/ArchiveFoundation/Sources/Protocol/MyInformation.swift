//
//  MyInformation.swift
//  ArchiveFoundation
//
//  Created by Aaron Hanwe LEE on 5/22/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation

public protocol MyInformation {
  
  var signInToken: SignInToken { get }
  var friendsList: [UserInformation] { get }
  
}
