import SwiftUI
import Domain
import Calendar
import UIComponents

@main
struct SampleApp: App {
  var body: some Scene {
    WindowGroup {
      ZStack {
        ATBackgroundView()
          .edgesIgnoringSafeArea(.all)
        
        VStack {
          CalendarView(reducer: CalendarReducer(initialState: .init()))
          Spacer()
        }
      }
    }
  }
}
