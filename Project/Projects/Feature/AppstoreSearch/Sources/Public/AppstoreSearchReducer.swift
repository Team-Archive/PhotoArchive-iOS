//
//  AppstoreSearchReducer.swift
//  AppstoreSearch
//
//  Created by Aaron Hanwe LEE on 1/31/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import ComposableArchitecture
import Foundation
import ArchiveFoundation
import Domain
import Combine

final class AppstoreSearchReducer: Reducer {
  
  // MARK: - TCA Define
  
  enum Action: Equatable {
    case setIsLoading(Bool)
    case setError(ArchiveError)
    case search(keyword: String)
    case requestMoreSearchData
    case setAppstoreAppList([AppstoreApp])
    case appendAppstoreAppList([AppstoreApp])
  }
  
  struct State: Equatable {
    var isLoading: Bool = false
    var err: ArchiveError?
    var AppList: [AppstoreApp] = []
  }
  
  // MARK: - Private Property
  
  private let appstoreSearchUsecase: AppstoreSearchUsecaseInterface
  
  // MARK: - Public Property
  
  // MARK: - LifeCycle
  
  init(usecase: AppstoreSearchUsecaseInterface) {
    self.appstoreSearchUsecase = usecase
  }
  
  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .setIsLoading(let isLoading):
        state.isLoading = isLoading
        return .none
      case .setError(let err):
        state.err = err
        return .none
      case .search(let keyword):
        return .concatenate([
          .send(.setIsLoading(true)),
          .run { send in
            let result = try await self.search(keyword: keyword).async()
            switch result {
            case .success(let list):
              await send(.setAppstoreAppList(list))
            case .failure(let err):
              await send(.setError(err))
            }
          },
          .send(.setIsLoading(false))
        ])
      case .requestMoreSearchData:
        return .concatenate([
          .send(.setIsLoading(true)),
          .run { send in
            let result = try await self.moreSearchData().async()
            switch result {
            case .success(let list):
              await send(.setAppstoreAppList(list))
            case .failure(let err):
              await send(.setError(err))
            }
          },
          .send(.setIsLoading(false))
        ])
      case .setAppstoreAppList(let list):
        state.AppList = list
        return .none
      case .appendAppstoreAppList(let list):
        state.AppList += list
        return .none
      }
    }
  }
  
  // MARK: - Private Method
  
  private func search(keyword: String) -> AnyPublisher<Result<[AppstoreApp], ArchiveError>, Never> {
    return self.appstoreSearchUsecase.search(keyword: keyword)
  }
  
  private func moreSearchData() -> AnyPublisher<Result<[AppstoreApp], ArchiveError>, Never> {
    return self.appstoreSearchUsecase.morePage()
  }
  
  // MARK: - Public Method
  
}


