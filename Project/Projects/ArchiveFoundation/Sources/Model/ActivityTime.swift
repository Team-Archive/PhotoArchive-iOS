//
//  ActivityTime.swift
//  ArchiveFoundation
//
//  Created by Aaron Hanwe LEE on 5/27/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

public struct ActivityTime {
  
  public let start: Double // 데이터 구조 대충 잡아놓은것. 개발할떄 변경 될 가능성 높음
  public let end: Double
  
  public init(start: Double, end: Double) {
    self.start = start
    self.end = end
  }
  
}
