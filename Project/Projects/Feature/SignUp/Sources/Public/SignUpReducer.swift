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
    case setProfilePhotoAsset(PHAsset)
    case setSelectedCity(City)
    case searchCity(keyword: String)
    case setSearchCityKeyword(keyword: String)
    case moreSearchCity
    case setCityList([City])
    case appendCityList([City])
    case selectActiveTime(willSelected: Bool, signUpActivityTime: SignUpActivityTime)
    case addActiveTime(timeInterval: ActivityTimeInterval)
    case selectCustomActiveTime(willSelected: Bool, index: Int)
    case setIsShowCustomActivityTimeMaker(Bool)
    case signUp
  }
  
  public struct State: Equatable {
    var isLoading: Bool = false
    var err: ArchiveError?
    let nicknameMaxLength: Int
    let oauthSignInData: OAuthSignInData
    var nicknameCandidate: String = ""
    var profilePhotoAsset: PHAsset?
    var isValidNickname: ValidNicknameResponse = .invalid(.empty)
    var selectedCity: City?
    var candidateCityList: [City] = []
    var searchCityKeyword: String = ""
    var selectedActivityTime: Set<SignUpActivityTime> = .init()
    var customActivityTime: [ActivityTimeInterval] = []
    var selectedCustomActivityTime: Set<Int> = .init()
    var isShowCustomActivityTimeMaker: Bool = false
  }
  
  // MARK: - Private Property
  
  private let updateProfileUsecase: UpdateProfileUsecase
  private let signUpUsecase: SignUpUsecase
  private let cityInfoUsecase: CityInfoUsecase
  private let signUpCompletion: (SignInToken) -> Void
  
  // MARK: - Internal Property
  
  var initialState: State
  
  // MARK: - Public Property
  
  // MARK: - LifeCycle
  
  public init(
    updateProfileUsecase: UpdateProfileUsecase,
    signUpUsecase: SignUpUsecase,
    cityInfoUsecase: CityInfoUsecase,
    nicknameMaxLength: Int,
    oauthSignInData: OAuthSignInData,
    completion: @escaping (SignInToken) -> Void
  ) {
    self.initialState = .init(
      nicknameMaxLength: nicknameMaxLength,
      oauthSignInData: oauthSignInData
    )
    self.updateProfileUsecase = updateProfileUsecase
    self.signUpUsecase = signUpUsecase
    self.cityInfoUsecase = cityInfoUsecase
    self.signUpCompletion = completion
  }
  
  public var body: some ReducerOf<Self> {
    Reduce {state, action in
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
      case .setProfilePhotoAsset(let asset):
        state.profilePhotoAsset = asset
        return .none
      case .setSelectedCity(let city):
        state.selectedCity = city
        return .none
      case .searchCity(let keyword):
        return .concatenate(
          .run(operation: { send in
            await send(.setIsLoading(true))
            let result = await self.searchCityList(keyword: keyword)
            switch result {
            case .success(let cityList):
              await send(.setCityList(cityList))
            case .failure(let err):
              await send(.setError(err))
            }
            await send(.setIsLoading(false))
          })
        )
      case .moreSearchCity:
        if self.cityInfoUsecase.isEndOfReach || self.cityInfoUsecase.isQuerying { return .none }
        return .concatenate(
          .run(operation: { send in
            await send(.setIsLoading(true))
            let result = await self.moreCityList()
            switch result {
            case .success(let cityList):
              await send(.appendCityList(cityList))
            case .failure(let err):
              await send(.setError(err))
            }
            await send(.setIsLoading(false))
          })
        )
      case .setSearchCityKeyword(let keyword):
        state.searchCityKeyword = keyword
        return .none
      case .setCityList(let list):
        state.candidateCityList = list
        return .none
      case .appendCityList(let list):
        state.candidateCityList += list
        return .none
      case .selectActiveTime(let willSelected, let signUpActivityTime):
        if willSelected {
          state.selectedActivityTime.insert(signUpActivityTime)
        } else {
          state.selectedActivityTime.remove(signUpActivityTime)
        }
        return .none
      case .signUp:
        let oauthSignInData = state.oauthSignInData
        guard let city = state.selectedCity else { return .send(.setError(.init(.requiredDataIsNotExist))) }
        let activityTimeValue = state.selectedActivityTime
        let photo = state.profilePhotoAsset
        if state.nicknameCandidate == "" { return .send(.setError(.init(.requiredDataIsNotExist))) }
        let nickname = state.nicknameCandidate
        return .concatenate(
          .run(operation: { send in
            await send(.setIsLoading(true))
            let signUpResult = await self.signUp(oauthData: oauthSignInData)
            switch signUpResult {
            case .success(let signInInfo):
              _ = await self.updateName(signInToken: signInInfo, name: nickname)
              _ = await self.updateLocation(signInToken: signInInfo, city: city)
              _ = await self.updateAvtivityTime(
                signInToken: signInInfo,
                city: city,
                activityTime: [:] // TODO: 작업
              )
              if let photo {
                _ = await self.updateProfilePhoto(signInToken: signInInfo, asset: photo)
              }
              self.signUpCompletion(signInInfo)
            case .failure(let err):
              await send(.setError(err))
            }
            await send(.setIsLoading(false))
          })
        )
      case .addActiveTime(let timeInterval):
        state.customActivityTime.append(timeInterval)
        return .none
      case .selectCustomActiveTime(let willSelected, let index):
        if willSelected {
          state.selectedCustomActivityTime.insert(index)
        } else {
          state.selectedCustomActivityTime.remove(index)
        }
        return .none
      case .setIsShowCustomActivityTimeMaker(let isShow):
        state.isShowCustomActivityTimeMaker = isShow
        return .none
      }
    }
  }
  
  // MARK: - Private Method
  
  private func isValidNickName(nickName: String, maxLength: Int) async -> Result<ValidNicknameResponse, ArchiveError> {
    return await self.updateProfileUsecase.isValidateNickname(nickName: nickName, maxLength: maxLength)
  }
  
  private func searchCityList(keyword: String) async -> Result<[City], ArchiveError> {
    return await self.cityInfoUsecase.searchCityList(keyword: keyword)
  }
  
  private func moreCityList() async -> Result<[City], ArchiveError> {
    return await self.cityInfoUsecase.moreCityList()
  }
  
  private func signUp(oauthData: OAuthSignInData) async -> Result<SignInToken, ArchiveError> {
    return await self.signUpUsecase.signUp(oauthData: oauthData)
  }
  
  private func updateLocation(signInToken: SignInToken, city: City) async -> Result<Void, ArchiveError> {
    return await self.updateProfileUsecase.updateLocation(
      signInToken: signInToken,
      city: city
    )
  }
  
  private func updateAvtivityTime(
    signInToken: SignInToken,
    city: City,
    activityTime: [DaysOfTheWeek: [ActivityTimeInterval]]
  ) async -> Result<Void, ArchiveError> {
    return await self.updateProfileUsecase.updateAvtivityTime(
      signInToken: signInToken,
      city: city,
      activityTime: activityTime
    )
  }
  
  private func updateName(signInToken: SignInToken, name: String) async -> Result<Void, ArchiveError> {
    return await self.updateProfileUsecase.updateName(
      signInToken: signInToken,
      name: name
    )
  }
  
  private func updateProfilePhoto(signInToken: SignInToken, asset: PHAsset) async -> Result<Void, ArchiveError> {
    return await self.updateProfileUsecase.updateProfilePhoto(
      signInToken: signInToken,
      asset: asset
    )
  }
  
  // MARK: - Public Method
  
}

