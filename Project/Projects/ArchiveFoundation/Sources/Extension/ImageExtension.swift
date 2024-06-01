//
//  ImageExtension.swift
//  ArchiveFoundation
//
//  Created by Aaron Hanwe LEE on 5/22/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import UIKit

extension Image {
  
  public init?(data: Data) {
    guard let uiImage = UIImage(data: data) else { return nil }
    self.init(uiImage: uiImage)
  }
  
}
