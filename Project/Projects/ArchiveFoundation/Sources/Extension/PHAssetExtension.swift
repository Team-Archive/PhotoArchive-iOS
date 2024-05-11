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
  
  private func toImage(size: CGSize) async -> Result<Image, ArchiveErrorCode> {
    let options = PHImageRequestOptions()
    options.isNetworkAccessAllowed = true
    options.deliveryMode = .highQualityFormat
    options.resizeMode = .exact
    
    return await withCheckedContinuation { continuation in
      PHImageManager.default().requestImage(for: self, targetSize: size, contentMode: .aspectFit, options: options) { uiImage, _ in
        if let uiImage = uiImage {
          let image = Image(uiImage: uiImage)
          continuation.resume(returning: .success(image))
        } else {
          continuation.resume(returning: .failure(.assetLoadingFailed))
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
        return .init(width: 300, height: 300)
      case .thumbnail:
        return .init(width: 200, height: 200)
      }
    }
  }
  
  public func toImage(_ type: PHAssetPhotoType) async -> Result<Image, ArchiveErrorCode> {
    return await self.toImage(size: type.size)
  }
  
}
