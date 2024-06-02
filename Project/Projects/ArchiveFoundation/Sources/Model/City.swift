//
//  City.swift
//  ArchiveFoundation
//
//  Created by Aaron Hanwe LEE on 5/27/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation

public struct City: Equatable {
  
  let id: String
  let name: String
  let country: Country
  let gmt: UInt
  
  public init(id: String, name: String, country: Country, gmt: UInt) {
    self.id = id
    self.name = name
    self.country = country
    self.gmt = gmt
  }
  
  public static func == (lhs: City, rhs: City) -> Bool {
    return lhs.id == rhs.id
  }
  
}
