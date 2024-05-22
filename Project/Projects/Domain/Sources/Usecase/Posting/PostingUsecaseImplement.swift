//
//  PostingUsecaseImplement.swift
//  Domain
//
//  Created by Aaron Hanwe LEE on 5/22/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import ArchiveFoundation
import Photos

public final class PostingUsecaseImplement: PostingUsecase {
  
  // MARK: - private properties
  
  private let repository: PostingRepository
  private let maxContentsCount: UInt
  
  // MARK: - internal properties
  
  // MARK: - life cycle
  
  public init(repository: PostingRepository, maxContentsCount: UInt) {
    self.repository = repository
    self.maxContentsCount = maxContentsCount
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
  public func post(accessToken: String, itemList: [PostingItem], toUserIdList: [String]) async -> Result<Void, ArchiveError> {
    return await self.repository.post(accessToken: accessToken, itemList: itemList, toUserIdList: toUserIdList)
  }
  
  public func assetListToImageDataList(assetList: [PHAsset]) async -> Result<[Data], ArchiveError> {
    var dataList: [Data] = []
    
    for asset in assetList {
      let result = await asset.toData(.detail)
      switch result {
      case .success(let data):
        dataList.append(data)
      case .failure(let error):
        print("Error converting asset to data: \(error)")
        return .failure(.init(.assetToDataFail))
      }
    }
    
    return .success(dataList)
  }
  
  public func isValidContents(contents: String?) -> Bool {
    if let contents {
      return !(contents.count > self.maxContentsCount)
    } else {
      return true
    }
  }
  
}
