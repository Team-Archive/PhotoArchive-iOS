//
//  AppstoreSearchUsecase.swift
//  Sample
//
//  Created by Aaron Hanwe LEE on 1/30/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import UIKit

public class AppstoreSearchUsecase: AppstoreSearchUsecaseInterface {
  
  // MARK: - private properties
  
  private let repository: AppstoreSearchRepository
  
  // MARK: - internal properties
  
  // MARK: - life cycle
  
  private init(repository: AppstoreSearchRepository) {
    self.repository = repository
  }
  
  // MARK: - private method
  
  // MARK: - public method
  
  public static func makeObject(repository: AppstoreSearchRepository) -> AppstoreSearchUsecaseInterface {
    return AppstoreSearchUsecase(repository: repository)
  }
  
  public func search(keyword: String) {
    
  }
  
  public func morePage() {
    
  }
  
}
