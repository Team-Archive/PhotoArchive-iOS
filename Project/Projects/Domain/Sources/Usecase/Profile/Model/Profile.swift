//
//  Profile.swift
//  Domain
//
//  Created by jinyoung on 8/6/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation

public struct Profile: Equatable {
  public let userID: Int
  public let name: String
  public let time: String
  public let region: String
  public let weather: ATWeather
  public let imageURL: URL?
  
  public init(userID: Int, name: String, time: String, region: String, weather: ATWeather, imageURL: URL?) {
    self.userID = userID
    self.name = name
    self.time = time
    self.region = region
    self.weather = weather
    self.imageURL = imageURL
  }
}
