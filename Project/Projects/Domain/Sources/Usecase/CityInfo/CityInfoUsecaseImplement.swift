//
//  CityInfoUsecaseImplement.swift
//  Domain
//
//  Created by Aaron Hanwe LEE on 5/27/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import ArchiveFoundation
import Foundation

public final class CityInfoUsecaseImplement: CityInfoUsecase {
  
  // MARK: - private properties
  
  private let repository: CityInfoRepository
  private let countOfResponsesPerQuestion: UInt
  private var currentPage: UInt = 0
  private var currentKeyword: String?
  
  // MARK: - public properties
  
  private(set) public var isEndOfReach: Bool = false
  private(set) public var isQuerying: Bool = false
  
  // MARK: - life cycle
  
  public init(
    countOfResponsesPerQuestion: UInt = 20,
    repository: CityInfoRepository
  ) {
    self.countOfResponsesPerQuestion = countOfResponsesPerQuestion
    self.repository = repository
  }
  
  // MARK: - private method
  
  private func cityList(keyword: String?, page: UInt) async -> Result<[City], ArchiveError> {
    self.isQuerying = true
    defer { self.isQuerying = false }
    
    let result = await repository.searchCityList(keyword: keyword, page: page)
    switch result {
    case .success(let cityList):
      if cityList.count < countOfResponsesPerQuestion {
        isEndOfReach = true
      }
      return .success(cityList)
    case .failure(let err):
      return .failure(err)
    }
  }
  
  private func resetPagination() {
    currentPage = 0
    isEndOfReach = false
  }
  
  // MARK: - public method
  
  public func searchCityList(keyword: String?) async -> Result<[City], ArchiveError> {
    resetPagination()
    currentKeyword = keyword
    return await cityList(
      keyword: keyword,
      page: self.currentPage
    )
  }
  
  public func moreCityList() async -> Result<[City], ArchiveError> {
    guard !isEndOfReach else {
      return .failure(.init(.endOfResults))
    }
    self.currentPage += 1
    return await cityList(
      keyword: self.currentKeyword,
      page: self.currentPage
    )
  }
  
}
