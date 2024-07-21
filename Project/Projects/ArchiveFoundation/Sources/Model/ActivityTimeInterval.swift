//
//  ActivityTimeInterval.swift
//  ArchiveFoundation
//
//  Created by Aaron Hanwe LEE on 5/27/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

public struct ActivityTimeInterval: Hashable {
  
  public struct Time: Hashable {
    public let hour: UInt
    public let minute: UInt
    
    public init(hour: UInt, minute: UInt) {
      self.hour = hour
      self.minute = minute
    }
    
    public static func == (lhs: Time, rhs: Time) -> Bool {
      return (lhs.hour == rhs.hour) && (lhs.minute == rhs.minute)
    }
  }
  
  public let start: Time
  public let end: Time
  
  public init(start: Time, end: Time) {
    self.start = start
    self.end = end
  }
  
  public static func == (lhs: ActivityTimeInterval, rhs: ActivityTimeInterval) -> Bool {
    return (lhs.start == rhs.start) && (lhs.end == rhs.end)
  }
  
}
