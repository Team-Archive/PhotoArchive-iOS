//
//  ActivityTimeInterval.swift
//  ArchiveFoundation
//
//  Created by Aaron Hanwe LEE on 5/27/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

public struct ActivityTimeInterval {
  
  public struct Time {
    public let hour: UInt
    public let minute: UInt
  }
  
  public let start: Time
  public let end: Time
  
  public init(start: Time, end: Time) {
    self.start = start
    self.end = end
  }
  
}
