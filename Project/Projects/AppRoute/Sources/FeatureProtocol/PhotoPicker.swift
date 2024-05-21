//
//  PhotoPicker.swift
//  AppRoute
//
//  Created by Aaron Hanwe LEE on 5/21/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import SwiftUI
import Photos

public protocol PhotoPicker where Self: View {
  
  init(completeAction: @escaping ([PHAsset]) -> Void, closeAction: @escaping () -> Void)
  
}
