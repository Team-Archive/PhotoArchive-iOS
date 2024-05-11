//
//  AlbumUsecaseImplement.swift
//  Domain
//
//  Created by hanwe on 5/1/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import Photos

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
        thumbnailAsset: fetchResult.lastObject
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
      
      let assets = PHAsset.fetchAssets(in: collection, options: nil)
      let firstAsset = assets.firstObject
      returnValue.append(
        .init(
          id: UUID(),
          name: collection.localizedTitle ?? collection.localIdentifier,
          count: collection.estimatedAssetCount,
          fetchResult: PHAsset.fetchAssets(in: collection, options: nil),
          thumbnailAsset: firstAsset
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
  
}
