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
          nicknameMaxLength: 24, 
          oauthSignInData: .apple(token: "123"),
          completion: { token in
            print("token: \(token)")
          }
        )
      )
    }
  }
}

final class StubCityInfoRepositoryImplement: CityInfoRepository {
  
  func searchCityList(keyword: String?, page: UInt) async -> Result<[City], ArchiveError> {
    usleep(1 * 1000 * 1000)
    if keyword == "1" {
      return .success([])
    }
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
      Country(name: "Brazil", code: "BR", emoji: "🇧🇷"),
      Country(name: "Russia", code: "RU", emoji: "🇷🇺"),
      Country(name: "China", code: "CN", emoji: "🇨🇳"),
      Country(name: "India", code: "IN", emoji: "🇮🇳"),
      Country(name: "Mexico", code: "MX", emoji: "🇲🇽"),
      Country(name: "South Africa", code: "ZA", emoji: "🇿🇦"),
      Country(name: "Egypt", code: "EG", emoji: "🇪🇬"),
      Country(name: "Argentina", code: "AR", emoji: "🇦🇷"),
      Country(name: "Spain", code: "ES", emoji: "🇪🇸"),
      Country(name: "Turkey", code: "TR", emoji: "🇹🇷"),
      Country(name: "Saudi Arabia", code: "SA", emoji: "🇸🇦"),
      Country(name: "Netherlands", code: "NL", emoji: "🇳🇱"),
      Country(name: "Sweden", code: "SE", emoji: "🇸🇪"),
      Country(name: "Norway", code: "NO", emoji: "🇳🇴"),
      Country(name: "Denmark", code: "DK", emoji: "🇩🇰"),
      Country(name: "Finland", code: "FI", emoji: "🇫🇮"),
      Country(name: "Switzerland", code: "CH", emoji: "🇨🇭"),
      Country(name: "Belgium", code: "BE", emoji: "🇧🇪"),
      Country(name: "Austria", code: "AT", emoji: "🇦🇹"),
      Country(name: "Portugal", code: "PT", emoji: "🇵🇹"),
      Country(name: "Greece", code: "GR", emoji: "🇬🇷"),
      Country(name: "New Zealand", code: "NZ", emoji: "🇳🇿"),
      Country(name: "Thailand", code: "TH", emoji: "🇹🇭"),
      Country(name: "Vietnam", code: "VN", emoji: "🇻🇳"),
      Country(name: "Malaysia", code: "MY", emoji: "🇲🇾"),
      Country(name: "Singapore", code: "SG", emoji: "🇸🇬"),
      Country(name: "Indonesia", code: "ID", emoji: "🇮🇩"),
      Country(name: "Philippines", code: "PH", emoji: "🇵🇭"),
      Country(name: "Pakistan", code: "PK", emoji: "🇵🇰"),
      Country(name: "Bangladesh", code: "BD", emoji: "🇧🇩")
    ]
    if keyword == "2" {
      let cities = [
        City(id: "1", name: "New York", country: countries[0], greenwichMeanTime: GreenwichMeanTime(hour: -4, minute: 0)),
        City(id: "2", name: "London", country: countries[1], greenwichMeanTime: GreenwichMeanTime(hour: 0, minute: 0)),
        City(id: "3", name: "Paris", country: countries[2], greenwichMeanTime: GreenwichMeanTime(hour: 1, minute: 0)),
        City(id: "4", name: "Tokyo", country: countries[3], greenwichMeanTime: GreenwichMeanTime(hour: 9, minute: 0)),
        City(id: "5", name: "Sydney", country: countries[4], greenwichMeanTime: GreenwichMeanTime(hour: 10, minute: 0)),
        City(id: "6", name: "Berlin", country: countries[5], greenwichMeanTime: GreenwichMeanTime(hour: 1, minute: 0)),
        City(id: "7", name: "Toronto", country: countries[6], greenwichMeanTime: GreenwichMeanTime(hour: -4, minute: 0)),
        City(id: "8", name: "Rome", country: countries[7], greenwichMeanTime: GreenwichMeanTime(hour: 1, minute: 0)),
        City(id: "9", name: "Seoul", country: countries[8], greenwichMeanTime: GreenwichMeanTime(hour: 9, minute: 0)),
        City(id: "10", name: "São Paulo", country: countries[9], greenwichMeanTime: GreenwichMeanTime(hour: -3, minute: 0)),
        City(id: "11", name: "Moscow", country: countries[10], greenwichMeanTime: GreenwichMeanTime(hour: 3, minute: 0)),
        City(id: "12", name: "Beijing", country: countries[11], greenwichMeanTime: GreenwichMeanTime(hour: 8, minute: 0)),
        City(id: "13", name: "Mumbai", country: countries[12], greenwichMeanTime: GreenwichMeanTime(hour: 5, minute: 30)),
        City(id: "14", name: "Mexico City", country: countries[13], greenwichMeanTime: GreenwichMeanTime(hour: -6, minute: 0)),
        City(id: "15", name: "Cape Town", country: countries[14], greenwichMeanTime: GreenwichMeanTime(hour: 2, minute: 0)),
        City(id: "16", name: "Cairo", country: countries[15], greenwichMeanTime: GreenwichMeanTime(hour: 2, minute: 0)),
        City(id: "17", name: "Buenos Aires", country: countries[16], greenwichMeanTime: GreenwichMeanTime(hour: -3, minute: 0)),
        City(id: "18", name: "Madrid", country: countries[17], greenwichMeanTime: GreenwichMeanTime(hour: 1, minute: 0)),
        City(id: "19", name: "Istanbul", country: countries[18], greenwichMeanTime: GreenwichMeanTime(hour: 3, minute: 0)),
        City(id: "20", name: "Riyadh", country: countries[19], greenwichMeanTime: GreenwichMeanTime(hour: 3, minute: 0))
      ]
      return .success(cities)
    } else {
      let cities = [
        City(id: "21", name: "Amsterdam", country: countries[20], greenwichMeanTime: GreenwichMeanTime(hour: 1, minute: 0)),
        City(id: "22", name: "Stockholm", country: countries[21], greenwichMeanTime: GreenwichMeanTime(hour: 1, minute: 0)),
        City(id: "23", name: "Oslo", country: countries[22], greenwichMeanTime: GreenwichMeanTime(hour: 1, minute: 0)),
        City(id: "24", name: "Copenhagen", country: countries[23], greenwichMeanTime: GreenwichMeanTime(hour: 1, minute: 0)),
        City(id: "25", name: "Helsinki", country: countries[24], greenwichMeanTime: GreenwichMeanTime(hour: 2, minute: 0)),
        City(id: "26", name: "Zurich", country: countries[25], greenwichMeanTime: GreenwichMeanTime(hour: 1, minute: 0)),
        City(id: "27", name: "Brussels", country: countries[26], greenwichMeanTime: GreenwichMeanTime(hour: 1, minute: 0)),
        City(id: "28", name: "Vienna", country: countries[27], greenwichMeanTime: GreenwichMeanTime(hour: 1, minute: 0)),
        City(id: "29", name: "Lisbon", country: countries[28], greenwichMeanTime: GreenwichMeanTime(hour: 0, minute: 0)),
        City(id: "30", name: "Athens", country: countries[29], greenwichMeanTime: GreenwichMeanTime(hour: 2, minute: 0)),
        City(id: "31", name: "Auckland", country: countries[30], greenwichMeanTime: GreenwichMeanTime(hour: 12, minute: 0)),
        City(id: "32", name: "Bangkok", country: countries[31], greenwichMeanTime: GreenwichMeanTime(hour: 7, minute: 0)),
        City(id: "33", name: "Hanoi", country: countries[32], greenwichMeanTime: GreenwichMeanTime(hour: 7, minute: 0)),
        City(id: "34", name: "Kuala Lumpur", country: countries[33], greenwichMeanTime: GreenwichMeanTime(hour: 8, minute: 0)),
        City(id: "35", name: "Singapore", country: countries[34], greenwichMeanTime: GreenwichMeanTime(hour: 8, minute: 0)),
        City(id: "36", name: "Jakarta", country: countries[35], greenwichMeanTime: GreenwichMeanTime(hour: 7, minute: 0)),
        City(id: "37", name: "Manila", country: countries[36], greenwichMeanTime: GreenwichMeanTime(hour: 8, minute: 0)),
        City(id: "38", name: "Karachi", country: countries[37], greenwichMeanTime: GreenwichMeanTime(hour: 5, minute: 0)),
        City(id: "39", name: "Dhaka", country: countries[38], greenwichMeanTime: GreenwichMeanTime(hour: 6, minute: 0)),
        City(id: "40", name: "Santiago", country: countries[16], greenwichMeanTime: GreenwichMeanTime(hour: -4, minute: 0))
      ]
      
      return .success(cities)
    }
  }
  
}


final class StubUpdateProfileRepositoryImplement: UpdateProfileRepository {
  
  func updateProfilePhoto(signInToken: SignInToken, asset: PHAsset) async -> Result<Void, ArchiveError> {
    return .success(())
  }
  
  func updateName(signInToken: SignInToken, name: String) async -> Result<Void, ArchiveError> {
    return .success(())
  }
  
  func updateLocation(signInToken: SignInToken, city: City) async -> Result<Void, ArchiveError> {
    return .success(())
  }
  
  func updateAvtivityTime(signInToken: SignInToken, city: City, activityTime: [DaysOfTheWeek: [ActivityTimeInterval]]) async -> Result<Void, ArchiveError> {
    return .success(())
  }
  
  func isDuplicatedName(_ name: String) async -> Result<Bool, ArchiveError> {
    return .success(name == "Test")
  }
  
}

final class StubSignUpRepositoryImplement: SignUpRepository {
  func signUp(oauthData: OAuthSignInData) async -> Result<SignInToken, ArchiveError> {
    return .success(
      .init(
        accessToken: "AccessToken",
        refreshToken: "RefreshToken"
      )
    )
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
          MockPHAsset()
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
