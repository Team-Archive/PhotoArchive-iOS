//
//  CollectionExtension.swift
//  ArchiveFoundation
//
//  Created by Aaron Hanwe LEE on 5/14/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation

extension Collection {
  public subscript (safe index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
}
