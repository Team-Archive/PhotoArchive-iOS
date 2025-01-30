//
//  MockImageURL.swift
//  ArchiveFoundation
//
//  Created by jinyoung on 1/29/25.
//  Copyright © 2025 TeamArchive. All rights reserved.
//

import Foundation

public struct MockImageURL {
  public static func fetchDatas(with count: Int) -> [URL] {
    return dummyImage.shuffled().suffix(count)
  }
  
  public static func fetchData() -> URL {
    return dummyImage.shuffled().suffix(1).first!
  }
}

// 더미 데이터 20개
fileprivate let dummyImage: [URL] = [
  URL(string: "https://i.pinimg.com/736x/2d/b3/46/2db34661160053fe9b3b3f543922c11e.jpg")!,
  URL(string: "https://i.pinimg.com/736x/93/e7/6b/93e76bd407e84f9fd985ce82a49914da.jpg")!,
  URL(string: "https://i.pinimg.com/736x/4e/b3/7d/4eb37d8a6002b65e431b91a292b133de.jpg")!,
  URL(string: "https://i.pinimg.com/736x/a0/63/86/a06386e2fe820552bda85b7fd77817f8.jpg")!,
  URL(string: "https://i.pinimg.com/736x/d3/81/e0/d381e071ceece8f7299ec9ffbec5405a.jpg")!,
  URL(string: "https://i.pinimg.com/736x/13/8f/9f/138f9f3df948455aafc3db15776a8bb8.jpg")!,
  URL(string: "https://i.pinimg.com/736x/81/8b/38/818b38f3450edf4a972a4f88401dc010.jpg")!,
  URL(string: "https://i.pinimg.com/736x/33/d6/53/33d653781a0a84bff4a01845e5dc62b1.jpg")!,
  URL(string: "https://i.pinimg.com/736x/2d/b3/29/2db329e4b404d68fc517ce7f239fc10e.jpg")!,
  URL(string: "https://i.pinimg.com/736x/99/b3/d6/99b3d6d4d0391fdab8d7e43b996a094d.jpg")!,
  URL(string: "https://i.pinimg.com/736x/b9/6c/ec/b96cec4d7d8053dbf33cf5e4d391236b.jpg")!,
  URL(string: "https://i.pinimg.com/736x/58/7d/d7/587dd7a086a2ce0bfe13718cbad0332a.jpg")!,
  URL(string: "https://i.pinimg.com/736x/40/7b/16/407b1686b80142c6e1413c873c1718f4.jpg")!,
  URL(string: "https://i.pinimg.com/736x/b6/82/11/b68211909e7c2e7f540c613bc6a8a341.jpg")!,
  URL(string: "https://i.pinimg.com/736x/48/a9/8a/48a98a565c1fb5618ab2115b521357f4.jpg")!,
  URL(string: "https://i.pinimg.com/736x/b3/b3/07/b3b3077aba8150acfc1adce5a772292f.jpg")!,
  URL(string: "https://i.pinimg.com/736x/ad/f4/96/adf496ddc8296b35c73bd22e890b1366.jpg")!,
  URL(string: "https://i.pinimg.com/736x/92/25/f7/9225f7f52406bf1b93f2e4e997aa4dbd.jpg")!,
  URL(string: "https://i.pinimg.com/736x/47/c1/80/47c180c984d41e454eb67d77c2f0c21a.jpg")!,
  URL(string: "https://i.pinimg.com/736x/cc/38/9b/cc389b460921c0a320838ff36a212867.jpg")!
]
