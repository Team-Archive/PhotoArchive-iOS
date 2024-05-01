//
//  Album.swift
//  Domain
//
//  Created by hanwe on 5/1/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import Photos

public struct Album: Equatable {
  
  public let id: UUID
  public let name: String
  public let count: Int
  public let fetchResult: PHFetchResult<PHAsset>
  public let thumbnailAsset: PHAsset?
  
  public static func == (lhs: Album, rhs: Album) -> Bool {
    return lhs.id == rhs.id
  }
  
}
