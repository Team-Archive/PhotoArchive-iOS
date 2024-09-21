//
//  SampleApp.swift
//  MyProfile
//
//  Created by jinyoung on 7/16/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
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
          
          ScrollView(.vertical) {
            VStack {
              MyProfileHeaderView(
                Profile(
                  name: "수지",
                  time: "10:40 PM",
                  region: "🇨🇦 Montreal, Canada",
                  weather: ATWeather(
                    tag: .cloudy,
                    temperature: 21
                  ),
                  imageURL: URL(
                    string: "https://i.pinimg.com/736x/a5/42/f7/a542f775abeeea554618fec94ed78a89.jpg"
                  )
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
                ), selectHandler: { selected in
                  guard let selected = selected else { return }
                  
                }
              ).padding(.horizontal, 20)
              
              Spacer()
            }
          }
        }
      }
    }
  }
}
