//
//  SignInTokenManagerTests.swift
//  App
//
//  Created by hanwe on 6/22/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import XCTest
import Domain
import ArchiveFoundation
@testable import App

final class SignInTokenManagerImplementTests: XCTestCase {
  
  private var manager: SignInTokenManagerImplement!
  private var usecase: MockManagementSignInTokenUsecase!
  
  override func setUp() {
    super.setUp()
    manager = SignInTokenManagerImplement.shared
    usecase = MockManagementSignInTokenUsecase()
    Task {
      await manager.configure(
        tokenUsecase: usecase,
        readWriteDataUsecase: MockReadWriteDataUsecase()
      )
    }
  }
  
  override func tearDown() {
    manager = nil
    usecase = nil
    super.tearDown()
  }
  
  func testConcurrentTokenRefresh() async {
    // Given
    let initAccessToken = "initialAccessToken"
    let initialToken = SignInToken(accessToken: initAccessToken, refreshToken: "initialRefreshToken")
    await manager.setSignInToken(initialToken)  // 테스트용 메서드로 signInToken 설정
    
    // When
    let concurrentRefreshTasks = (0..<10).map { _ in
      Task {
        let signInToken = await manager.signInToken
        if signInToken?.accessToken == initAccessToken {
          _ = await manager.refreshSignInToken()
        }
      }
    }
    
    await withTaskGroup(of: Void.self) { group in
      for task in concurrentRefreshTasks {
        group.addTask {
          await task.value
        }
      }
    }
    
    // Then
    let updatedToken = await manager.signInToken
    XCTAssertNotNil(updatedToken, "토큰 갱신 성공 시, signInToken이 nil이 아님을 확인합니다.")
    XCTAssertEqual(updatedToken?.accessToken, "newAccessToken1", "토큰 갱신 후, 새로운 accessToken이 'newAccessToken1'인지 확인합니다.")
    XCTAssertEqual(usecase.refreshCallCount, 1, "리프레시 토큰 호출은 단 한 번만 발생해야 합니다.")
  }
  
}

// Mock Usecase
final class MockManagementSignInTokenUsecase: ManagementSignInTokenUsecase {
  
  private(set) var refreshCallCount = 0
  
  func refreshSignInToken(refreshToken: String) async -> Result<SignInToken, ArchiveError> {
    refreshCallCount += 1
    let newToken = SignInToken(accessToken: "newAccessToken\(refreshCallCount)", refreshToken: "newRefreshToken")
    return .success(newToken)
  }
}

// Mock Usecase
final class MockReadWriteDataUsecase: ReadWriteDataUsecase {
  
  func write(key: String, data: Data) async -> Result<Void, ArchiveError> {
    return .success(())
  }
  
  func read(key: String) async -> Result<Data?, ArchiveError> {
    return .success(nil)
  }
  
  func update(key: String, data: Data) async -> Result<Void, ArchiveError> {
    return .success(())
  }
  
  func delete(key: String) async -> Result<Void, ArchiveError> {
    return .success(())
  }
  
}

