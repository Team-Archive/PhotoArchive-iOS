//
//  NicknameValidatorTests.swift
//  Domain
//
//  Created by Aaron Hanwe LEE on 6/4/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import XCTest
@testable import Domain

final class NicknameValidatorTests: XCTestCase {
  
  var validator: NicknameValidator!
  
  // MARK: - Setup
  override func setUp() {
    super.setUp()
    validator = NicknameValidator()
  }
  
  // MARK: - Teardown
  override func tearDown() {
    validator = nil
    super.tearDown()
  }
  
  // MARK: - Tests
  
  func test_isValidate_withEmptyString_shouldReturnFalse() {
    // Given
    let nickname = ""
    let maxLength = 10
    
    // When
    let isValid = validator.isValidate(nickname, maxLength: maxLength)
    
    // Then
    XCTAssertEqual(isValid, .invalid(.empty), "Empty string should be invalid")
  }
  
  func test_isValidate_withWhitespaceOnlyString_shouldReturnFalse() {
    // Given
    let nickname = "     "
    let maxLength = 10
    
    // When
    let isValid = validator.isValidate(nickname, maxLength: maxLength)
    
    // Then
    XCTAssertEqual(isValid, .invalid(.onlySpace), "String with only whitespaces should be invalid")
  }
  
  func test_isValidate_withValidNickname_shouldReturnTrue() {
    // Given
    let nickname = "validName"
    let maxLength = 10
    
    // When
    let isValid = validator.isValidate(nickname, maxLength: maxLength)
    
    // Then
    XCTAssertEqual(isValid, .valid, "Valid nickname should be valid")
  }
  
  func test_isValidate_withNicknameExceedingMaxLength_shouldReturnFalse() {
    // Given
    let nickname = "exceedingMaxLength"
    let maxLength = 10
    
    // When
    let isValid = validator.isValidate(nickname, maxLength: maxLength)
    
    // Then
    XCTAssertEqual(isValid, .invalid(.overLength), "Nickname exceeding max length should be invalid")
  }
  
  func test_isValidate_withMaxLengthNickname_shouldReturnTrue() {
    // Given
    let nickname = "1234567890"
    let maxLength = 10
    
    // When
    let isValid = validator.isValidate(nickname, maxLength: maxLength)
    
    // Then
    XCTAssertEqual(isValid, .valid, "Nickname with exactly max length should be valid")
  }
  
}
