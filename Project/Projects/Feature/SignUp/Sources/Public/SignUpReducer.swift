//
//  SignUpReducer.swift
//  SignUp
//
//  Created by hanwe on 5/25/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import ComposableArchitecture
import Foundation
import ArchiveFoundation
import Domain

public struct SignUpReducer: Reducer {
  
  // MARK: - TCA Define
  
  public enum Action: Equatable {
    case setIsLoading(Bool)
    case setError(ArchiveError)
  }
  
  public struct State: Equatable {
    var isLoading: Bool = false
    var err: ArchiveError?
  }
  
  // MARK: - Private Property
  
  // MARK: - Public Property
  
  // MARK: - LifeCycle
  
  public init(
    
  ) {
    
  }
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .setIsLoading(let isLoading):
        state.isLoading = isLoading
        return .none
      case .setError(let err):
        state.err = err
        return .none
      }
    }
  }
  
  // MARK: - Private Method
  
  // MARK: - Public Method
  
}

