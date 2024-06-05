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
  let greenwichMeanTime: Int
  
  public init(id: String, name: String, country: Country, greenwichMeanTime: Int) {
    self.id = id
    self.name = name
    self.country = country
    self.greenwichMeanTime = greenwichMeanTime
  }
  
  public static func == (lhs: City, rhs: City) -> Bool {
    return lhs.id == rhs.id
  }
  
}
