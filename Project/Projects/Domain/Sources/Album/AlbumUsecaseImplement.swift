//
//  AlbumUsecaseImplement.swift
//  Domain
//
//  Created by hanwe on 5/1/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import Photos
import ArchiveFoundation

public final class AlbumUsecaseImplement: AlbumUsecase {
  
  // MARK: private property
  
  private let recentAlbumName: String
  
  // MARK: internal property
  
  // MARK: lifeCycle
  
  public init(recentAlbumName: String) {
    self.recentAlbumName = recentAlbumName
  }
  
  // MARK: private function
  
  private func fetchAllPhotoAlbum() -> Album {
    let allPhotosOptions: PHFetchOptions = PHFetchOptions()
    allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
    let fetchResult: PHFetchResult<PHAsset> = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: allPhotosOptions)
    return (
      .init(
        id: UUID(),
        name: self.recentAlbumName,
        count: fetchResult.count,
        fetchResult: fetchResult,
        thumbnailAsset: fetchResult.firstObject
      )
    )
  }
  
  private func fetchAllAlbums() -> [Album] {
    var returnValue: [Album] = []
    
    let options = PHFetchOptions()
    let userAlbums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: options)
    
    userAlbums.enumerateObjects { (collection, count: Int, stop: UnsafeMutablePointer) in
      let fetchOptions = PHFetchOptions()
      fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
      fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
      
      let assets = PHAsset.fetchAssets(in: collection, options: fetchOptions)
      returnValue.append(
        .init(
          id: UUID(),
          name: collection.localizedTitle ?? collection.localIdentifier,
          count: assets.count,
          fetchResult: assets,
          thumbnailAsset: assets.firstObject
        )
      )
    }
    
    return returnValue
  }
  
  // MARK: public function
  
  public func fetchAlbumList() -> [Album] {
    return [self.fetchAllPhotoAlbum()] + self.fetchAllAlbums()
  }
  
  public func checkAlbumPermission() async -> PHAuthorizationStatus {
    let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
    
    switch status {
    case .notDetermined:
      return await withCheckedContinuation { continuation in
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { newStatus in
          continuation.resume(returning: newStatus)
        }
      }
    default:
      return status
    }
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
