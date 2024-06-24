//
//  EdgeInsetsExtension.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 6/7/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import SwiftUI

extension EdgeInsets {
  public static var designContentsSideInsets: EdgeInsets {
    return .init(
      top: 0,
      leading: .designContentsInset,
      bottom: 0,
      trailing: .designContentsInset
    )
  }
}
