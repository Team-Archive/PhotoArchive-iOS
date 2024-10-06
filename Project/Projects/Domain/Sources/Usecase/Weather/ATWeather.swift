//
//  ATWeather.swift
//  Domain
//
//  Created by jinyoung on 8/7/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation

public struct ATWeather: Equatable {
  public let tag: ATWeatherTag
  public let temperature: Float
  
  public init(tag: ATWeatherTag, temperature: Float) {
    self.tag = tag
    self.temperature = temperature
  }
}
