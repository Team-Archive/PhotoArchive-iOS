//
//  MyProfileHeaderView.swift
//  MyProfile
//
//  Created by jinyoung on 7/16/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import Domain
import UIComponents

public struct MyProfileHeaderView: View {
  // MARK: - public state
  
  // MARK: - private properties
  private let profile: Profile
  private let editHandler: () -> Void
  
  // MARK: - life cycle
  public init(_ profile: Profile, editHandler: @escaping () -> Void) {
    self.profile = profile
    self.editHandler = editHandler
  }
  
  public var body: some View {
    VStack {
      ProfileInfoView()
    }
  }
  
  // MARK: - private method
  @ViewBuilder
  private func ProfileInfoView() -> some View {
    HStack {
      VStack(alignment: .leading, spacing: 4) {
        Text(profile.name)
          .font(.fonts(.bodyBold16))
          .foregroundStyle(Gen.Colors.white.color)
        
        Text(profile.time)
          .font(.fonts(.body14))
          .foregroundStyle(Gen.Colors.white.color)
        
        HStack {
          Text(profile.region)
            .font(.fonts(.body14))
            .foregroundStyle(Gen.Colors.white.color)
          
          ATWeatherTagView(
            designType: .primary,
            weather: profile.weather.tag.convertToTag(),
            temperature: profile.weather.temperature
          )
        }
      }
      
      Spacer()
      
      ATUrlImage(url: profile.imageURL)
          .aspectRatio(contentMode: .fill)
          .clipShape(.circle)
          .frame(width: 68, height: 68)
          .overlay {
            Gen.Images.editProfileButton.image
              .frame(width: 28, height: 28)
              .offset(x: -34, y: 20)
              .onTapGesture {
                editHandler()
              }
          }
    }
    .padding(.horizontal, 20)
    .frame(height: 68)
  }
}

// TODO: 임시
extension ATWeatherTag {
  func convertToTag() -> ATWeatherTagView.Weather {
    switch self {
    case .cloudy:
      return .cloudy
    }
  }
}
