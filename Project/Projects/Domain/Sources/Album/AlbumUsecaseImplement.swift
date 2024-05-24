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
  private let favoriteAlbumName: String
  private let sortDescriptors: [NSSortDescriptor] = [NSSortDescriptor(key: "creationDate", ascending: false)]
  
  // MARK: internal property
  
  // MARK: lifeCycle
  
  public init(
    recentAlbumName: String,
    favoriteAlbumName: String
  ) {
    self.recentAlbumName = recentAlbumName
    self.favoriteAlbumName = favoriteAlbumName
  }
  
  // MARK: private function
  
  private func fetchAllPhotoAlbum() -> Album {
    let allPhotosOptions: PHFetchOptions = PHFetchOptions()
    allPhotosOptions.sortDescriptors = self.sortDescriptors
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
      fetchOptions.sortDescriptors = self.sortDescriptors
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
  
  private func fetchFavoriteAlbum() -> Album {
    let fetchOptions = PHFetchOptions()
    fetchOptions.predicate = NSPredicate(format: "favorite == YES")
    fetchOptions.sortDescriptors = self.sortDescriptors
    let assets: PHFetchResult<PHAsset> = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOptions)
    return .init(
      id: UUID(),
      name: self.favoriteAlbumName,
      count: assets.count,
      fetchResult: assets,
      thumbnailAsset: assets.firstObject
    )
  }
  
  private func fetchScreenshotAlbum() -> Album? {
    return self.fetchSubTyleAlbum(.smartAlbumScreenshots)
  }
  
  private func fetchSelfieAlbum() -> Album? {
    return self.fetchSubTyleAlbum(.smartAlbumSelfPortraits)
  }
  
  private func fetchSubTyleAlbum(_ type: PHAssetCollectionSubtype) -> Album? {
    let album = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: type, options: nil)
    guard let collection = album.firstObject else { return nil }
    let fetchOptions = PHFetchOptions()
    fetchOptions.sortDescriptors = self.sortDescriptors
    fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
    let assets = PHAsset.fetchAssets(in: collection, options: fetchOptions)
    return .init(
      id: UUID(),
      name: collection.localizedTitle ?? collection.localIdentifier,
      count: assets.count,
      fetchResult: assets,
      thumbnailAsset: assets.firstObject
    )
  }
  
  // MARK: public function
  
  public func fetchAlbumList() -> [Album] {
    let selfieAlbum: [Album] = {
      guard let album = self.fetchSelfieAlbum() else { return [] }
      return [album]
    }()
    let screenshotAlbum: [Album] = {
      guard let album = self.fetchScreenshotAlbum() else { return [] }
      return [album]
    }()
    return [self.fetchAllPhotoAlbum()] + [self.fetchFavoriteAlbum()] + selfieAlbum + screenshotAlbum + self.fetchAllAlbums()
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
