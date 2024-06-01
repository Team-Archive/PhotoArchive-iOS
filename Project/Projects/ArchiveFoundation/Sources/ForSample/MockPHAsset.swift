//
//  MockPHAsset.swift
//  ArchiveFoundation
//
//  Created by Aaron Hanwe LEE on 5/22/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Photos
import Foundation

public class MockPHAsset: PHAsset { // 이 클래스의 오브젝트가 목데이터인지 실제 서비스코드에서 알 수 있는 방법이 있을까? 있다면 이 패키지에서 빠지고, 별도의 샘플코드들만을 위한 패키지에 들어가있으면 좋을 것 같다.
  let _localIdentifier: String = UUID().uuidString
  let _hash: Int = UUID().hashValue
  
  public override var localIdentifier: String {
    return _localIdentifier
  }
  
  public override var hash: Int {
    return _hash
  }
  
  public override func isEqual(_ object: Any?) -> Bool {
    guard let object = object as? MockPHAsset else {
      return false
    }
    return self.localIdentifier == object.localIdentifier
  }
}
