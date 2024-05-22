//
//  PostingUsecaseTests.swift
//  Domain
//
//  Created by Aaron Hanwe LEE on 5/22/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import XCTest
@testable import Domain
import ArchiveFoundation

class PostingUsecaseTests: XCTestCase {
  
  var usecase: PostingUsecase!
  
  override func setUpWithError() throws {
    
  }
  
  override func tearDownWithError() throws {
    
  }
  
  func testIsValidContents() {
    // Given
    let usecase = PostingUsecaseImplement(repository: StubPostRepositoryImplement(), maxContentsCount: 100)
    let validContent = "유효한 콘텐츠입니다"
    let invalidContent = String(repeating: "a", count: 101)
    
    // When
    let isValidValidContent = usecase.isValidContents(contents: validContent)
    let isInvalidContent = usecase.isValidContents(contents: invalidContent)
    let isNilContent = usecase.isValidContents(contents: nil)
    
    // Then
    XCTAssertTrue(isValidValidContent, "유효한 콘텐츠는 true여야 합니다")
    XCTAssertFalse(isInvalidContent, "유효하지 않은 콘텐츠는 false여야 합니다")
    XCTAssertTrue(isNilContent, "nil 콘텐츠는 true여야 합니다")
  }
  
}

fileprivate final class StubPostRepositoryImplement: PostingRepository {
  func post(accessToken: String, itemList: [PostingItem], toUserIdList: [String]) async -> Result<Void, ArchiveError> {
    return .success(())
  }
}
