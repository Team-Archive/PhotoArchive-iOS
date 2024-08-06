//
//  ATWeatherTag.swift
//  Domain
//
//  Created by jinyoung on 8/7/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import SwiftUI
import UIComponents

public enum ATWeatherTag: Int {
  case cloudy = 0
  
  public func convertToTag() -> ATWeatherTagView.Weather {
    switch self {
    case .cloudy:
      return .cloudy
    }
  }
}
