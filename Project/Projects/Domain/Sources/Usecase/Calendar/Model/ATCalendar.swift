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
  public let photo: Image?
  
  public init(date: Date?, photoURL: URL?, photo: Image?) {
    self.id = UUID()
    self.date = date
    self.photoURL = photoURL
    self.photo = photo
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
    hasher.combine(date)
  }
  
  public var day: String {
    guard let date = date else {
      return ""
    }
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d"
    return dateFormatter.string(from: date)
  }
  
  public static let empty = ATCalendar(date: nil, photoURL: nil, photo: nil)
}
