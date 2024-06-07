//
//  ActivityTimeIntervalExtensionTests.swift
//  SignUp
//
//  Created by Aaron Hanwe LEE on 6/7/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import XCTest
import ArchiveFoundation
@testable import SignUp

final class ActivityTimeIntervalTests: XCTestCase {
  
  func testTo12HourFormat() {
    // Given: A time interval from 7:00 to 9:00
    let startTime = ActivityTimeInterval.Time(hour: 7, minute: 0)
    let endTime = ActivityTimeInterval.Time(hour: 9, minute: 0)
    let interval = ActivityTimeInterval(start: startTime, end: endTime)
    
    // When: Converting to 12-hour format
    let result = interval.to12HourFormat()
    
    // Then: The result should be "07:00 AM - 09:00 AM"
    XCTAssertEqual(result, "07:00 AM - 09:00 AM")
  }
  
  func testTo12HourFormatPM() {
    // Given: A time interval from 13:00 to 15:00
    let startTime = ActivityTimeInterval.Time(hour: 13, minute: 0)
    let endTime = ActivityTimeInterval.Time(hour: 15, minute: 0)
    let interval = ActivityTimeInterval(start: startTime, end: endTime)
    
    // When: Converting to 12-hour format
    let result = interval.to12HourFormat()
    
    // Then: The result should be "01:00 PM - 03:00 PM"
    XCTAssertEqual(result, "01:00 PM - 03:00 PM")
  }
  
  func testTo12HourFormatMidnight() {
    // Given: A time interval from 0:00 to 1:00
    let startTime = ActivityTimeInterval.Time(hour: 0, minute: 0)
    let endTime = ActivityTimeInterval.Time(hour: 1, minute: 0)
    let interval = ActivityTimeInterval(start: startTime, end: endTime)
    
    // When: Converting to 12-hour format
    let result = interval.to12HourFormat()
    
    // Then: The result should be "12:00 AM - 01:00 AM"
    XCTAssertEqual(result, "12:00 AM - 01:00 AM")
  }
  
  func testTo12HourFormatNoon() {
    // Given: A time interval from 12:00 to 13:00
    let startTime = ActivityTimeInterval.Time(hour: 12, minute: 0)
    let endTime = ActivityTimeInterval.Time(hour: 13, minute: 0)
    let interval = ActivityTimeInterval(start: startTime, end: endTime)
    
    // When: Converting to 12-hour format
    let result = interval.to12HourFormat()
    
    // Then: The result should be "12:00 PM - 01:00 PM"
    XCTAssertEqual(result, "12:00 PM - 01:00 PM")
  }
  
}
