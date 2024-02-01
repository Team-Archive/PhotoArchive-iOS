//
//  AppstoreSearchResultModel.swift
//  Sample
//
//  Created by Aaron Hanwe LEE on 1/30/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct AppstoreApp: Decodable, Equatable {
  
  public let name: String
  
  public init?(rawJson: JSON) {
    guard let name = rawJson["trackName"].string else { return nil }
    self.init(name: name)
  }
  
  public init(name: String) {
    self.name = name
  }
  
}
