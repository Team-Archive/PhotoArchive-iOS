//
//  ATCalendar.swift
//  Domain
//
//  Created by jinyoung on 6/11/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import SwiftUI

public struct ATCalendar: Equatable, Identifiable, Hashable {
  public let id: UUID
  public let date: Date?
  public let photoURL: URL?
  
  public init(date: Date?, photoURL: URL?) {
    self.id = UUID()
    self.date = date
    self.photoURL = photoURL
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
    hasher.combine(date)
  }
  
  public var day: String {
    guard let date = date else {
      return ""
    }
    
    return date.formatTod()
  }
  
  public static let empty = ATCalendar(date: nil, photoURL: nil)
}
