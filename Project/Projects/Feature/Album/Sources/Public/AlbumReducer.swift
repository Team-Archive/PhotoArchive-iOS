//
//  AlbumReducer.swift
//  Album
//
//  Created by hanwe on 5/1/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import ComposableArchitecture
import Foundation
import ArchiveFoundation
import Domain
import Combine

public struct AlbumReducer: Reducer {
  
  // MARK: - TCA Define
  
  public enum Action: Equatable { // Equatable을 채택한 이유는 테스트 가능하게 만들기 위함
    case setIsLoading(Bool)
    case setError(ArchiveError)
    case search(keyword: String)
    case requestMoreSearchData
    case setAppstoreAppList([AppstoreApp])
    case appendAppstoreAppList([AppstoreApp])
  }
  
  public struct State: Equatable { // Equatable을 채택하는 이유: class와 같은 참조타입이면 값이 변해도 주소값이 같기 때문에 변화를 감지하기 어려움. 100% 변화를 감지하기 위해서 값타입과 Equatable을 채택
    var isLoading: Bool = false
    var err: ArchiveError?
    /*@BindingState*/ var appList: [AppstoreApp] = [] // BindingState를 사용하면 외부에서 값을 변경 할 수 있으나, 캡슐화를 손상시키기 때문에 권장하지는 않는다. 다만 복잡성 감소를 위해 만들어 놓은듯;
  }
  
  // MARK: - Private Property
  
  private let appstoreSearchUsecase: AppstoreSearchUsecaseInterface
  
  private enum CancelId {
    case search
  }
  
  // MARK: - Public Property
  
  // MARK: - LifeCycle
  
  public init(usecase: AppstoreSearchUsecaseInterface) {
    self.appstoreSearchUsecase = usecase
  }
  
  public var body: some /*Reducer<State, Action>*/ ReducerOf<Self> {
    @Dependency(\.timeZone) var timeZone // KeyPath를 사용해 의존성을 주입할 수 있음. 내가 만든 appstoreSearchUsecase도 이렇게 주입이 가능한가? -> 가능은 하지만 Interface로 사용하지는 못하는듯. 더 문제는 구체 클래스로 사용한다고 해도, 구현체를 어떻게 바꿔치기 하느냐가 더 문제가 되는듯..? DependencyExtensionSample 참조
    Reduce { state, action in
      switch action {
      case .setIsLoading(let isLoading):
        state.isLoading = isLoading
        return .none
      case .setError(let err):
        state.err = err
        return .none
      case .search(let keyword):
        return Effect.concatenate( // 사용자가 검색을 두 번 누른다면 이전 검색을 취소하고, 새로운 검색을 시작한다.
          .cancel(id: CancelId.search),
          .concatenate([
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
            }.cancellable(id: CancelId.search),
            .send(.setIsLoading(false))
          ])
        )
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


