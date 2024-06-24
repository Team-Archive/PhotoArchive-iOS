//
//  CityInfoRepository.swift
//  Domain
//
//  Created by Aaron Hanwe LEE on 5/27/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import ArchiveFoundation
import Foundation

public protocol CityInfoRepository {
  func searchCityList(keyword: String?, page: UInt) async -> Result<[City], ArchiveError>
}
