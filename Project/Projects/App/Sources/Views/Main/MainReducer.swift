//
//  MainReducer.swift
//  App
//
//  Created by hanwe on 10/20/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import ComposableArchitecture
import Foundation
import ArchiveFoundation
import Domain
import DomainInterface
import Combine

public struct MainReducer: Reducer {
  
  // MARK: - TCA Define
  
  public enum Action: Equatable {
    case action(ViewAction)
    case mutate(Mutation)
  }
  
  public enum ViewAction: Equatable {
    case bindingLoginStatus
  }
  
  public enum Mutation: Equatable {
    case setIsLoading(Bool)
    case setError(ArchiveError?)
    case setIsLoggedIn(Bool)
  }
  
  public struct State: Equatable {
    var isLoading: Bool = false
    var err: ArchiveError?
    var isLoggedIn: Bool = false
  }
  
  // MARK: - Private Property
  
  private let signInManager: SignInManagerImplement = .shared
  
  // MARK: - Internal Property
  
  var initialState: State
  
  // MARK: - Public Property
  
  // MARK: - LifeCycle
  
  public init(
    
  ) {
    self.initialState = .init()
  }
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .action(let action):
        switch action {
        case .bindingLoginStatus:
          return .merge(
            .publisher(self.signInManager.isLoggedInStream
              .receive(on: DispatchQueue.main)
              .map { isLoggedIn in
                return .mutate(.setIsLoggedIn(isLoggedIn))
              }
              .eraseToAnyPublisher
            )
          )
        }
      case .mutate(let mutation):
        switch mutation {
        case .setIsLoading(let isLoading):
          state.isLoading = isLoading
          return .none
        case .setError(let err):
          state.err = err
          return .none
        case .setIsLoggedIn(let isLoggedIn):
          state.isLoggedIn = isLoggedIn
          return .none
        }
      }
    }
  }
  
  // MARK: - Private Method
  
  // MARK: - Public Method
  
}
