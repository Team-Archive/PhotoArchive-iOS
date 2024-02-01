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

public final class AppstoreSearchReducer: Reducer {
  
  // MARK: - TCA Define
  
  public enum Action: Equatable {
    case setIsLoading(Bool)
    case setError(ArchiveError)
    case search(keyword: String)
    case requestMoreSearchData
    case setAppstoreAppList([AppstoreApp])
    case appendAppstoreAppList([AppstoreApp])
  }
  
  public struct State: Equatable {
    var isLoading: Bool = false
    var err: ArchiveError?
    var appList: [AppstoreApp] = []
  }
  
  // MARK: - Private Property
  
  private let appstoreSearchUsecase: AppstoreSearchUsecaseInterface
  
  // MARK: - Public Property
  
  // MARK: - LifeCycle
  
  public init(usecase: AppstoreSearchUsecaseInterface) {
    self.appstoreSearchUsecase = usecase
  }
  
  public var body: some Reducer<State, Action> {
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
              print("검색결과: \(list)")
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
        state.appList = list
        return .none
      case .appendAppstoreAppList(let list):
        state.appList += list
        return .none
      }
    }
  }
  
  // MARK: - Private Method
  
  private func search(keyword: String) -> AnyPublisher<Result<[AppstoreApp], ArchiveError>, Never> {
    print("검색: \(keyword)")
    return self.appstoreSearchUsecase.search(keyword: keyword)
  }
  
  private func moreSearchData() -> AnyPublisher<Result<[AppstoreApp], ArchiveError>, Never> {
    return self.appstoreSearchUsecase.morePage()
  }
  
  // MARK: - Public Method
  
}


