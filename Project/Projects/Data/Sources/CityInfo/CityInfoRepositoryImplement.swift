//
//  CityInfoRepositoryImplement.swift
//  Data
//
//  Created by hanwe on 10/20/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import Domain
import ArchiveFoundation

public final class CityInfoRepositoryImplement: CityInfoRepository {
  
  public init() {
    
  }
  
  public func searchCityList(keyword: String?, page: UInt) async -> Result<[City], ArchiveError> {
    // TODO: 구현
    return .failure(.init(.commonError))
  }
}
