//
//  DateExtension.swift
//  ArchiveFoundation
//
//  Created by jinyoung on 6/23/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation

extension Date {
  private func getFormatter() -> DateFormatter {
    let dateFormatter = DateFormatter()
    return dateFormatter
  }
  
  // MARK: yyyy.M
  public func formatToyyyyM() -> String {
    let dateFormatter = getFormatter()
    dateFormatter.dateFormat = "yyyy.M"
    return dateFormatter.string(from: self)
  }
}
