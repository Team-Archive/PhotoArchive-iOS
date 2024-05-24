//
//  AlbumUsecase.swift
//  Domain
//
//  Created by hanwe on 5/1/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import Photos
import ArchiveFoundation

public protocol AlbumUsecase {
  func fetchAlbumList() -> [Album]
  func checkAlbumPermission() async -> PHAuthorizationStatus
  func assetListToImageDataList(assetList: [PHAsset]) async -> Result<[Data], ArchiveError>
}
