//
//  CityInfoUsecase.swift
//  Domain
//
//  Created by Aaron Hanwe LEE on 5/27/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import ArchiveFoundation
import Foundation

public protocol CityInfoUsecase {
  
  var isEndOfReach: Bool { get }
  var isQuerying: Bool { get }
  
  /**
   이 메소드들은 threa safe함을 보장하지 않습니다.
   */
  func searchCityList(keyword: String?) async -> Result<[City], ArchiveError>
  func moreCityList() async -> Result<[City], ArchiveError>
  
}
