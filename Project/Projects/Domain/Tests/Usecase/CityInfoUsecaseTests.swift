//
//  CityInfoUsecaseTests.swift
//  Domain
//
//  Created by Aaron Hanwe LEE on 5/27/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import XCTest
import ArchiveFoundation
@testable import Domain

final class CityInfoUsecaseImplementTests: XCTestCase {
  
  var sut: CityInfoUsecaseImplement!
  var repositoryStub: CityInfoRepositoryStub!
  
  override func setUp() {
    super.setUp()
    repositoryStub = CityInfoRepositoryStub()
    sut = CityInfoUsecaseImplement(
      countOfResponsesPerQuestion: 3,
      repository: repositoryStub
    )
  }
  
  override func tearDown() {
    sut = nil
    repositoryStub = nil
    super.tearDown()
  }
  
  // Given-When-Then: 도시 목록 검색 성공
  func testSearchCityList_Success() async {
    // Given
    let expectedCities = [
      City(id: "1", name: "New York", country: Country(name: "USA", code: "US", emoji: "🇺🇸"), greenwichMeanTime: .init(hour: 5, minute: 0)),
      City(id: "2", name: "Los Angeles", country: Country(name: "USA", code: "US", emoji: "🇺🇸"), greenwichMeanTime: .init(hour: 8, minute: 0)),
      City(id: "3", name: "Chicago", country: Country(name: "USA", code: "US", emoji: "🇺🇸"), greenwichMeanTime: .init(hour: 6, minute: 0))
    ]
    repositoryStub.cities = expectedCities
    
    // When
    let result = await sut.searchCityList(keyword: "a")
    
    // Then
    switch result {
    case .success(let cities):
      XCTAssertEqual(cities, expectedCities, "예상된 도시 목록이 반환되어야 합니다.")
      XCTAssertFalse(sut.isEndOfReach, "isEndOfReach가 false여야 합니다.")
    case .failure:
      XCTFail("성공을 예상했으나 실패했습니다.")
    }
  }
  
  // Given-When-Then: 도시 목록 검색 성공, 더이상 데이터 없음
  func testSearchCityListButEndOfReach_Success() async {
    // Given
    let expectedCities = [
      City(id: "1", name: "New York", country: Country(name: "USA", code: "US", emoji: "🇺🇸"), greenwichMeanTime: .init(hour: 5, minute: 0)),
      City(id: "2", name: "Los Angeles", country: Country(name: "USA", code: "US", emoji: "🇺🇸"), greenwichMeanTime: .init(hour: 8, minute: 0))
    ]
    repositoryStub.cities = expectedCities
    
    // When
    let result = await sut.searchCityList(keyword: "a")
    
    // Then
    switch result {
    case .success(let cities):
      XCTAssertEqual(cities, expectedCities, "예상된 도시 목록이 반환되어야 합니다.")
      XCTAssertTrue(sut.isEndOfReach, "isEndOfReach가 true여야 합니다.")
    case .failure:
      XCTFail("성공을 예상했으나 실패했습니다.")
    }
  }
  
  // Given-When-Then: 추가 도시 목록 성공
  func testMoreCityList_Success() async {
    // Given
    let initialCities = [
      City(id: "1", name: "New York", country: Country(name: "USA", code: "US", emoji: "🇺🇸"), greenwichMeanTime: .init(hour: 5, minute: 0)),
      City(id: "2", name: "Los Angeles", country: Country(name: "USA", code: "US", emoji: "🇺🇸"), greenwichMeanTime: .init(hour: 8, minute: 0)),
      City(id: "3", name: "Chicago", country: Country(name: "USA", code: "US", emoji: "🇺🇸"), greenwichMeanTime: .init(hour: 6, minute: 0))
    ]
    let moreCities = [
      City(id: "4", name: "Houston", country: Country(name: "USA", code: "US", emoji: "🇺🇸"), greenwichMeanTime: .init(hour: 6, minute: 0)),
      City(id: "5", name: "Phoenix", country: Country(name: "USA", code: "US", emoji: "🇺🇸"), greenwichMeanTime: .init(hour: 7, minute: 0)),
      City(id: "6", name: "Philadelphia", country: Country(name: "USA", code: "US", emoji: "🇺🇸"), greenwichMeanTime: .init(hour: 5, minute: 0))
    ]
    repositoryStub.cities = initialCities
    await _ = sut.searchCityList(keyword: "a")
    
    repositoryStub.cities = moreCities
    
    // When
    let result = await sut.moreCityList()
    
    // Then
    switch result {
    case .success(let cities):
      XCTAssertEqual(cities, moreCities, "예상된 추가 도시 목록이 반환되어야 합니다.")
    case .failure:
      XCTFail("성공을 예상했으나 실패했습니다.")
    }
  }
  
}

class CityInfoRepositoryStub: CityInfoRepository {
  
  var cities: [City] = []
  
  func searchCityList(keyword: String?, page: UInt) async -> Result<[City], ArchiveError> {
    return .success(cities)
  }
}
