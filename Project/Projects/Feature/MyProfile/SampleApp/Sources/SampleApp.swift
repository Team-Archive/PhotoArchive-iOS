//
//  SampleApp.swift
//  MyProfile
//
//  Created by jinyoung on 7/16/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import ArchiveFoundation
import Domain
import Calendar
import UIComponents
import MyProfile

@main
struct SampleApp: App {
  var body: some Scene {
    WindowGroup {
      ZStack {
        ATBackgroundView()
          .edgesIgnoringSafeArea(
            .all
          )
        
        VStack {
          ATNavigationBar(
            type: .default(
              backAction: nil,
              trailingAction: nil
            )
          )
          
          GeometryReader { geometry in
            ScrollView(.vertical) {
              VStack {
                MyProfileHeaderView(
                  Profile(
                    userID: 1,
                    name: "수지",
                    time: "10:40 PM",
                    region: "🇨🇦 Montreal, Canada",
                    weather: ATWeather(
                      tag: .cloudy,
                      temperature: 21
                    ),
                    imageURL: MockImageURL.fetchData()
                  )) {
                    print("profile edit clicked")
                  }
                
                MonthRecapView()
                
                Spacer()
                  .frame(height: 20)
                
                CalendarView(
                  reducer: CalendarReducer(
                    selectedMonth: Date(),
                    useCase: CalendarUsecaseImpl(
                      repository: StubCalendarRepositoryImpl()
                    )
                  )
                ).padding(.horizontal, 20)
                
                Spacer()
                  .frame(height: 20)
                
  //              CalendarDetailView()
  //                .padding(.horizontal, 20)

                ATGridImageView(
                  geometry: geometry,
                  data: MockImageURL.fetchDatas(with: 5)
                    .compactMap { ATGridImageView.ATGridImageItem(url: $0) },
                  tapHandler: { item in
                  print("Tap Grid Image View : \(item)")
                }).padding(.horizontal, 20)

                Spacer()
              }
            }
          }
        }
      }
    }
  }
}
