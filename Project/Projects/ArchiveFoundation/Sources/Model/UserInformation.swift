//
//  UserInformation.swift
//  ArchiveFoundation
//
//  Created by Aaron Hanwe LEE on 5/22/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation

public struct UserInformation: Identifiable, Equatable {
  
  public var id: String
  public var name: String
  public var profileSmallUrl: URL?
  public var profileUrl: URL?
  
  public init(id: String, name: String, profileSmallUrl: URL? = nil, profileUrl: URL? = nil) {
    self.id = id
    self.name = name
    self.profileSmallUrl = profileSmallUrl
    self.profileUrl = profileUrl
  }
  
  public static func == (lhs: UserInformation, rhs: UserInformation) -> Bool {
    return lhs.id == rhs.id
  }
  
}
