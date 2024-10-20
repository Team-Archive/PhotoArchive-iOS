//
//  MyInformationManager.swift
//  DomainInterface
//
//  Created by hanwe on 10/20/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import ArchiveFoundation
import Foundation
import Combine

public protocol MyInformationManager {
  var infomationStream: CurrentValueSubject<UserInformation?, Never> { get }
}
