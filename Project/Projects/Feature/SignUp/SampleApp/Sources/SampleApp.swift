//
//  App.swift
//  ArchiveFoundation
//
//  Created by hanwe on 1/28/24.
//  Copyright © 2024 Archive. All rights reserved.
//

import SwiftUI
import SignUp
import Domain
import ArchiveFoundation
import Photos
import AppRoute

@main
struct SampleApp: App {
  var body: some Scene {
    WindowGroup {
      SignUpView<StubPhotoPickerView>(
        reducer: SignUpReducer(
          updateProfileUsecase: UpdateProfileUsecaseImplement(repository: StubUpdateProfileRepositoryImplement()),
          signUpUsecase: SignUpUsecaseImplement(repository: StubSignUpRepositoryImplement()), 
          cityInfoUsecase: CityInfoUsecaseImplement(repository: StubCityInfoRepositoryImplement()),
          nicknameMaxLength: 24
        )
      )
    }
  }
}

final class StubCityInfoRepositoryImplement: CityInfoRepository {
  
  func searchCityList(keyword: String?, page: UInt) async -> Result<[City], ArchiveError> {
    usleep(1 * 1000 * 1000)
    let countries = [
      Country(name: "United States", code: "US", emoji: "🇺🇸"),
      Country(name: "United Kingdom", code: "GB", emoji: "🇬🇧"),
      Country(name: "France", code: "FR", emoji: "🇫🇷"),
      Country(name: "Japan", code: "JP", emoji: "🇯🇵"),
      Country(name: "Australia", code: "AU", emoji: "🇦🇺"),
      Country(name: "Germany", code: "DE", emoji: "🇩🇪"),
      Country(name: "Canada", code: "CA", emoji: "🇨🇦"),
      Country(name: "Italy", code: "IT", emoji: "🇮🇹"),
      Country(name: "South Korea", code: "KR", emoji: "🇰🇷"),
      Country(name: "Brazil", code: "BR", emoji: "🇧🇷")
    ]
    
    let cities = [
      City(id: "1", name: "New York", country: countries[0], greenwichMeanTime: 4),
      City(id: "2", name: "London", country: countries[1], greenwichMeanTime: 0),
      City(id: "3", name: "Paris", country: countries[2], greenwichMeanTime: 1),
      City(id: "4", name: "Tokyo", country: countries[3], greenwichMeanTime: 9),
      City(id: "5", name: "Sydney", country: countries[4], greenwichMeanTime: 10),
      City(id: "6", name: "Berlin", country: countries[5], greenwichMeanTime: 1),
      City(id: "7", name: "Toronto", country: countries[6], greenwichMeanTime: 4),
      City(id: "8", name: "Rome", country: countries[7], greenwichMeanTime: 1),
      City(id: "9", name: "Seoul", country: countries[8], greenwichMeanTime: 9),
      City(id: "10", name: "São Paulo", country: countries[9], greenwichMeanTime: -3)
    ]
    
    return .success(cities)
  }
  
}


final class StubUpdateProfileRepositoryImplement: UpdateProfileRepository {
  
  func updateProfilePhoto(asset: PHAsset) async -> Result<Void, ArchiveError> {
    return .success(())
  }
  
  func isDuplicatedName(_ name: String) async -> Result<Bool, ArchiveError> {
    return .success(name == "Test")
  }
  
  func updateName(_ name: String) async -> Result<Void, ArchiveError> {
    return .success(())
  }
  
}

final class StubSignUpRepositoryImplement: SignUpRepository {
  
  func signUp(name: String, cityId: String, preferTime: [DaysOfTheWeek: [ActivityTime]]) async -> Result<String, ArchiveError> {
    return .success("token")
  }
  
}

struct StubPhotoPickerView: View, PhotoPicker {
  
  var closeAction: (() -> Void)
  var completeAction: (([PHAsset]) -> Void)
  
  init(
    completeAction: @escaping ([PHAsset]) -> Void,
    closeAction: @escaping () -> Void
  ) {
    self.completeAction = completeAction
    self.closeAction = closeAction
  }
  
  public var body: some View {
    VStack(spacing: 20) {
      Button(action: {
        completeAction([
          MockPHAsset(),
        ])
      }, label: {
        VStack {
          Text("This is StubPhotoPickerView")
          Text("Click here")
        }
      })
      Button(action: {
        closeAction()
      }, label: {
        Text("This is close action")
      })
    }
  }
  
}
