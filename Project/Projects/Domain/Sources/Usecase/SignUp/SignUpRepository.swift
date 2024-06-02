//
//  SignUpRepository.swift
//  Domain
//
//  Created by Aaron Hanwe LEE on 5/27/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import ArchiveFoundation
import Foundation

public protocol SignUpRepository {
  func signUp(name: String, cityId: String, preferTime: [DaysOfTheWeek: [ActivityTime]]) async -> Result<String, ArchiveError>
}
