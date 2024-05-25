//
//  Country.swift
//  ArchiveFoundation
//
//  Created by hanwe on 5/25/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation

public struct Country: Decodable, Equatable {
  
  public let name: String
  public let code: String
  public let emoji: String
  
  public enum CodingKeys: String, CodingKey {
    case name
    case code
    case emoji = "flag"
  }
  
  public init(name: String, code: String, emoji: String) {
    self.name = name
    self.code = code
    self.emoji = emoji
  }
  
  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.name = try container.decode(String.self, forKey: .name)
    self.code = try container.decode(String.self, forKey: .code)
    self.emoji = try container.decode(String.self, forKey: .emoji)
  }
  
  public static func == (lhs: Country, rhs: Country) -> Bool {
    return lhs.code == rhs.code
  }
  
  public static func allCountryList() -> [Country] {
    var returnValue: [Country] = []
    
    for item in JSONFiles.countryList {
      guard let name: String = item[CodingKeys.name.rawValue] as? String else { continue }
      guard let code: String = item[CodingKeys.code.rawValue] as? String else { continue }
      guard let emoji: String = item[CodingKeys.emoji.rawValue] as? String else { continue }
      returnValue.append(
        .init(
          name: name,
          code: code,
          emoji: emoji
        )
      )
    }
    
    return returnValue.sorted { $0.name < $1.name }
  }
  
}
