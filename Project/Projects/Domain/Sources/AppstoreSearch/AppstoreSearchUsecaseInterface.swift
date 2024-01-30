//
//  AppstoreSearchUsecaseInterface.swift
//  Sample
//
//  Created by Aaron Hanwe LEE on 1/30/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation

public protocol AppstoreSearchUsecaseInterface {
  
  static func makeObject(repository: AppstoreSearchRepository) -> AppstoreSearchUsecaseInterface
  
  func search(keyword: String)
  func morePage()
  
}
