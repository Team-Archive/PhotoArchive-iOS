//
//  CountryTests.swift
//  ArchiveFoundation
//
//  Created by hanwe on 5/25/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import XCTest
@testable import ArchiveFoundation

class CountryTests: XCTestCase {
  
  func testCountryDecoding() {
    // Given
    let json = """
        [
            {
                "name": "Afghanistan",
                "code": "AF",
                "flag": "🇦🇫"
            },
            {
                "name": "Albania",
                "code": "AL",
                "flag": "🇦🇱"
            }
        ]
        """.data(using: .utf8)!
    
    // When
    let countries: [Country]
    do {
      countries = try JSONDecoder().decode([Country].self, from: json)
    } catch {
      XCTFail("디코딩 실패: \(error)")
      return
    }
    
    // Then
    XCTAssertEqual(countries.count, 2)
    XCTAssertEqual(countries[0].name, "Afghanistan")
    XCTAssertEqual(countries[0].code, "AF")
    XCTAssertEqual(countries[0].emoji, "🇦🇫")
    XCTAssertEqual(countries[1].name, "Albania")
    XCTAssertEqual(countries[1].code, "AL")
    XCTAssertEqual(countries[1].emoji, "🇦🇱")
  }
  
  func testAllCountryList() {
    // Given
    // 번들에 country.json 파일이 있으면
    
    // When
    let countries = Country.allCountryList()
    
    // Then
    XCTAssertNotNil(countries, "allCountryList()는 nil을 반환해서는 안 됩니다")
    XCTAssertGreaterThan(countries.count, 0, "국가 목록은 비어 있지 않아야 합니다")
    
    // 특정 국가가 목록에 포함되어 있는지 확인하는 예제 테스트
    if let afghanistan = countries.first(where: { $0.code == "AF" }) {
      XCTAssertEqual(afghanistan.name, "Afghanistan")
      XCTAssertEqual(afghanistan.emoji, "🇦🇫")
    } else {
      XCTFail("국가 목록에 아프가니스탄이 포함되어 있어야 합니다")
    }
    
    // 국가 목록이 알파벳 순서로 정렬되어 있는지 확인하는 테스트
    let sortedCountries = countries.sorted { $0.name < $1.name }
    XCTAssertEqual(countries, sortedCountries, "국가 목록은 알파벳 순서로 정렬되어 있어야 합니다")
  }
}
