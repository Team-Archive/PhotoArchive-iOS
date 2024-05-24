//
//  IntExtension.swift
//  ArchiveFoundation
//
//  Created by Aaron Hanwe LEE on 5/14/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation

extension Int {
  public func toDotString() -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    return numberFormatter.string(from: NSNumber(value: self)) ?? ""
  }
}
