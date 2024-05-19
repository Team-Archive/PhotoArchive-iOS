//
//  Album.swift
//  Domain
//
//  Created by hanwe on 5/1/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import Photos

public struct Album: Equatable, Identifiable {
  
  public let id: UUID
  public let name: String
  public let count: Int
  public let fetchResult: PHFetchResult<PHAsset>
  public let thumbnailAsset: PHAsset?
  
  public static func == (lhs: Album, rhs: Album) -> Bool {
    return lhs.id == rhs.id
  }
  
  public init(id: UUID, name: String, count: Int, fetchResult: PHFetchResult<PHAsset>, thumbnailAsset: PHAsset?) {
    self.id = id
    self.name = name
    self.count = count
    self.fetchResult = fetchResult
    self.thumbnailAsset = thumbnailAsset
  }
  
}
