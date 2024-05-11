//
//  ArchiveCommonUtil.swift
//  ArchiveFoundation
//
//  Created by Aaron Hanwe LEE on 5/10/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import UIKit

public final class ArchiveCommonUtil {
  
  // MARK: - private properties
  
  // MARK: - internal properties
  
  // MARK: - life cycle
  
  // MARK: - private method
  
  // MARK: - internal method
  
  public static func openSetting() {
    
    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
    
    if UIApplication.shared.canOpenURL(settingsUrl) {
      UIApplication.shared.open(settingsUrl)
    }
    
  }

}
