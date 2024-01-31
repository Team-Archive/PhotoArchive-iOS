//
//  AppstoreSearchUsecase.swift
//  Sample
//
//  Created by Aaron Hanwe LEE on 1/30/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import UIKit
import Combine
import ArchiveFoundation

public class AppstoreSearchUsecase: AppstoreSearchUsecaseInterface {
  
  // MARK: - private properties
  
  private let repository: AppstoreSearchRepository
  private let limit: UInt = 10
  private var currentPage: UInt = 0
  private var searchKeyword: String?
  
  // MARK: - internal properties
  
  public var isQuerying: Bool = false
  public var isFinishPage: Bool = false
  
  // MARK: - life cycle
  
  private init(repository: AppstoreSearchRepository) {
    self.repository = repository
  }
  
  // MARK: - private method
  
  private func searchItem(keyword: String, page: UInt) -> AnyPublisher<[AppstoreApp], ArchiveError> {
    self.isQuerying = true
    return self.repository.search(
      keyword: keyword,
      offset: page,
      limit: self.limit
    )
    .handleEvents(
      receiveOutput: { [weak self] list in
        if list.count < self?.limit ?? 10 {
          self?.isFinishPage = true
        }
        self?.currentPage += 1
      },
      receiveCompletion: { [weak self] result in
        self?.isQuerying = false
      }
    )
    .eraseToAnyPublisher()
  }
  
  // MARK: - public method
  
  public static func makeObject(repository: AppstoreSearchRepository) -> AppstoreSearchUsecaseInterface {
    return AppstoreSearchUsecase(repository: repository)
  }
  
  public func search(keyword: String) -> AnyPublisher<[AppstoreApp], ArchiveError> {
    self.currentPage = 0
    self.isFinishPage = false
    self.searchKeyword = keyword
    return searchItem(keyword: keyword, page: self.currentPage)
  }
  
  public func morePage() -> AnyPublisher<[AppstoreApp], ArchiveError> {
    guard let searchKeyword else {
      return Future<[AppstoreApp], ArchiveError> { promise in
        promise(.success([]))
      }
      .eraseToAnyPublisher()
    }
    return self.searchItem(keyword: searchKeyword, page: self.currentPage)
  }
  
}
