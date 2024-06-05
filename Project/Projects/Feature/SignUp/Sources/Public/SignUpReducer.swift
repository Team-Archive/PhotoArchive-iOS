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
import Photos

public struct SignUpReducer: Reducer {
  
  // MARK: - TCA Define
  
  public enum Action: Equatable {
    case setIsLoading(Bool)
    case setError(ArchiveError)
    case setNickname(String)
    case setIsValidNickname(ValidNicknameResponse)
    case checkValidateNickname(String)
  }
  
  public struct State: Equatable {
    var isLoading: Bool = false
    var err: ArchiveError?
    let nicknameMaxLength: Int
    var nicknameCandidate: String = ""
    var profilePhotoAsset: PHAsset?
    var isValidNickname: ValidNicknameResponse = .invalid(.empty)
  }
  
  // MARK: - Private Property
  
  private let updateProfileUsecase: UpdateProfileUsecase
  private let signUpUsecase: SignUpUsecase
  
  // MARK: - Internal Property
  
  var initialState: State
  
  // MARK: - Public Property
  
  // MARK: - LifeCycle
  
  public init(
    updateProfileUsecase: UpdateProfileUsecase,
    signUpUsecase: SignUpUsecase,
    nicknameMaxLength: Int
  ) {
    self.initialState = .init(nicknameMaxLength: nicknameMaxLength)
    self.updateProfileUsecase = updateProfileUsecase
    self.signUpUsecase = signUpUsecase
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
      case .setNickname(let nicknameCandidate):
        if state.nicknameCandidate != nicknameCandidate {
          state.isValidNickname = .invalid(.none)
        }
        state.nicknameCandidate = nicknameCandidate
        return .none
      case .setIsValidNickname(let isValid):
        state.isValidNickname = isValid
        return .none
      case .checkValidateNickname(let nicknameCandidate):
        let maxLength = state.nicknameMaxLength
        return .concatenate(
          .run(operation: { send in
            await send(.setIsLoading(true))
            let result = await self.isValidNickName(nickName: nicknameCandidate, maxLength: maxLength)
            switch result {
            case .success(let isValid):
              await send(.setIsValidNickname(isValid))
            case .failure(let err):
              await send(.setError(err))
            }
            await send(.setIsLoading(false))
          })
        )
      }
    }
  }
  
  // MARK: - Private Method
  
  private func isValidNickName(nickName: String, maxLength: Int) async -> Result<ValidNicknameResponse, ArchiveError> {
    return await self.updateProfileUsecase.isValidateNickname(nickName: nickName, maxLength: maxLength)
  }
  
  // MARK: - Public Method
  
}

