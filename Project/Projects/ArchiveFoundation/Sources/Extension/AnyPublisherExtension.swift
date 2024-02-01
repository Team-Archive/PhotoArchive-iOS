//
//  CombineExtension.swift
//  ArchiveFoundation
//
//  Created by Aaron Hanwe LEE on 1/31/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import Combine

extension AnyPublisher {
  public func async() async throws -> Output {
    try await withCheckedThrowingContinuation { continuation in
      var cancellable: AnyCancellable?
      
      cancellable = first()
        .sink { result in
          switch result {
          case .finished:
            break
          case let .failure(error):
            continuation.resume(throwing: error)
          }
          cancellable?.cancel()
        } receiveValue: { value in
          continuation.resume(with: .success(value))
        }
    }
  }
}
