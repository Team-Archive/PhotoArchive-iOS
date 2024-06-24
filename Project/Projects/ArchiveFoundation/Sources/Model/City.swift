//
//  City.swift
//  ArchiveFoundation
//
//  Created by Aaron Hanwe LEE on 5/27/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation

public struct City: Equatable {
  
  public let id: String
  public let name: String
  public let country: Country
  public let greenwichMeanTime: GreenwichMeanTime
  
  public init(id: String, name: String, country: Country, greenwichMeanTime: GreenwichMeanTime) {
    self.id = id
    self.name = name
    self.country = country
    self.greenwichMeanTime = greenwichMeanTime
  }
  
  public static func == (lhs: City, rhs: City) -> Bool {
    return lhs.id == rhs.id
  }
  
}
