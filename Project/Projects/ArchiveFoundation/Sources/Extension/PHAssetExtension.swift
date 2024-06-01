//
//  PHAssetExtension.swift
//  ArchiveFoundation
//
//  Created by Aaron Hanwe LEE on 5/10/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import Photos

extension PHAsset {
  
  // MARK: private method
  
  private func toImage(size: CGSize) async -> Result<Image, ArchiveError> {
    let options = PHImageRequestOptions()
    options.isNetworkAccessAllowed = true
    options.deliveryMode = .highQualityFormat
    options.resizeMode = .exact
    options.isSynchronous = true
    
    return await withCheckedContinuation { continuation in
      if self is MockPHAsset {
        continuation.resume(returning: .failure(.init(.assetLoadingFailed)))
        return
      }
      PHImageManager.default().requestImage(for: self, targetSize: size, contentMode: .aspectFit, options: options) { uiImage, _ in
        if let uiImage = uiImage {
          let image = Image(uiImage: uiImage)
          continuation.resume(returning: .success(image))
        } else {
          continuation.resume(returning: .failure(.init(.assetLoadingFailed)))
        }
      }
    }
  }
  
  private func toData(size: CGSize) async -> Result<Data, ArchiveError> {
    let options = PHImageRequestOptions()
    options.isNetworkAccessAllowed = true
    options.deliveryMode = .highQualityFormat
    options.resizeMode = .exact
    options.isSynchronous = true
    
    return await withCheckedContinuation { continuation in
      PHImageManager.default().requestImage(for: self, targetSize: size, contentMode: .aspectFit, options: options) { uiImage, _ in
        if let uiImage = uiImage, let imageData = uiImage.jpegData(compressionQuality: 1.0) {
          continuation.resume(returning: .success(imageData))
        } else {
          continuation.resume(returning: .failure(.init(.assetLoadingFailed)))
        }
      }
    }
  }
  
  // MARK: public method
  
  public enum PHAssetPhotoType {
    case thumbnail
    case detail
    
    var size: CGSize {
      switch self {
      case .detail:
        return .init(width: 500, height: 500)
      case .thumbnail:
        return .init(width: 300, height: 300)
      }
    }
  }
  
  public func toImage(_ type: PHAssetPhotoType) async -> Result<Image, ArchiveError> {
    return await self.toImage(size: type.size)
  }
  
  public func toData(_ type: PHAssetPhotoType) async -> Result<Data, ArchiveError> {
    return await self.toData(size: type.size)
  }
  
}
