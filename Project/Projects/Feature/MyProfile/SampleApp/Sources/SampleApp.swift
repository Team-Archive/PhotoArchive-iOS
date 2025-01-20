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
                  )
                ).padding(.horizontal, 20)
                
                Spacer()
                  .frame(height: 20)
                
  //              CalendarDetailView()
  //                .padding(.horizontal, 20)
                
                let gridData4 = [
                  ATGridImageView.ATGridImageItem(url: URL(string: "https://i.pinimg.com/736x/c2/9a/88/c29a881f6f0cd83ea62775aabf51e1d6.jpg")!),
                  ATGridImageView.ATGridImageItem(url: URL(string: "https://i.pinimg.com/736x/c2/9a/88/c29a881f6f0cd83ea62775aabf51e1d6.jpg")!),
                  ATGridImageView.ATGridImageItem(url: URL(string: "https://i.pinimg.com/736x/c2/9a/88/c29a881f6f0cd83ea62775aabf51e1d6.jpg")!),
                  ATGridImageView.ATGridImageItem(url: URL(string: "https://i.pinimg.com/736x/c2/9a/88/c29a881f6f0cd83ea62775aabf51e1d6.jpg")!)
                ]
                ATGridImageView(geometry: geometry, data: gridData4, tapHandler: { item in
                  
                }).padding(.horizontal, 20)
                
                let gridData3 = [
                  ATGridImageView.ATGridImageItem(url: URL(string: "https://i.pinimg.com/564x/60/be/20/60be20c0ee942b2199d9d2663c5c4c05.jpg")!),
                  ATGridImageView.ATGridImageItem(url: URL(string: "https://i.pinimg.com/564x/60/be/20/60be20c0ee942b2199d9d2663c5c4c05.jpg")!),
                  ATGridImageView.ATGridImageItem(url: URL(string: "https://i.pinimg.com/564x/60/be/20/60be20c0ee942b2199d9d2663c5c4c05.jpg")!)
                ]
                ATGridImageView(geometry: geometry, data: gridData3, tapHandler: { item in
                  
                }).padding(.horizontal, 20)
                
                let gridData5 = [
                  ATGridImageView.ATGridImageItem(url: URL(string: "https://i.pinimg.com/564x/60/be/20/60be20c0ee942b2199d9d2663c5c4c05.jpg")!),
                  ATGridImageView.ATGridImageItem(url: URL(string: "https://i.pinimg.com/564x/60/be/20/60be20c0ee942b2199d9d2663c5c4c05.jpg")!),
                  ATGridImageView.ATGridImageItem(url: URL(string: "https://i.pinimg.com/564x/60/be/20/60be20c0ee942b2199d9d2663c5c4c05.jpg")!),
                  ATGridImageView.ATGridImageItem(url: URL(string: "https://i.pinimg.com/736x/c2/9a/88/c29a881f6f0cd83ea62775aabf51e1d6.jpg")!),
                  ATGridImageView.ATGridImageItem(url: URL(string: "https://i.pinimg.com/736x/c2/9a/88/c29a881f6f0cd83ea62775aabf51e1d6.jpg")!)
                ]
                ATGridImageView(geometry: geometry, data: gridData5, tapHandler: { item in
                  
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
