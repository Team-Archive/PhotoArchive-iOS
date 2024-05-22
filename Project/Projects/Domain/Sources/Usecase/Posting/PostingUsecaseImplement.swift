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
  
  // MARK: - internal properties
  
  // MARK: - life cycle
  
  public init(repository: PostingRepository) {
    self.repository = repository
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
  public func post(accessToken: String, itemList: [PostingItem]) async -> Result<Void, ArchiveError> {
    return await self.repository.post(accessToken: accessToken, itemList: itemList)
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
  
}
