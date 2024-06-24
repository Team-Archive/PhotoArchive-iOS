//
//  ATWatchTimeSelectorView.swift
//  UIComponents
//
//  Created by hanwe on 6/15/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import ArchiveFoundation

public struct ATWatchTimeSelectorView: View {
  
  private enum Theme {
    case morning
    case afternoon
    case evening
    case night
    
    var startColor: Color {
      switch self {
      case .morning:
        return Gen.Colors.gradationMorningStart.color
      case .afternoon:
        return Gen.Colors.gradationAfternoonStart.color
      case .evening:
        return Gen.Colors.gradationEveningStart.color
      case .night:
        return Gen.Colors.gradationNightStart.color
      }
    }
    
    var endColor: Color {
      switch self {
      case .morning:
        return Gen.Colors.gradationMorningEnd.color
      case .afternoon:
        return Gen.Colors.gradationAfternoonEnd.color
      case .evening:
        return Gen.Colors.gradationEveningEnd.color
      case .night:
        return Gen.Colors.gradationNightEnd.color
      }
    }
    
    static func from(meridiem: Meridiem, hour: Int) -> Theme {
      switch meridiem {
      case .am:
        switch hour {
        case 1...5, 12:
          return .night
        case 6...11:
          return .morning
        default:
          return .night
        }
      case .pm:
        switch hour {
        case 12, 1...5:
          return .afternoon
        case 6...8:
          return .evening
        case 9...11:
          return .night
        default:
          return .afternoon
        }
      }
    }
    
  }
  
  // MARK: - private property
  
  @Binding private var selectedHour: Int
  @Binding private var meridiem: Meridiem
  @State private var angle: Angle = .degrees(0)
  private let hours = Array(1...12)
  private let feedbackGenerator: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
  
  // MARK: - internal property
  
  // MARK: - lifeCycle
  
  public init(
    selectedHour: Binding<Int>,
    meridiem: Binding<Meridiem>
  ) {
    self._selectedHour = selectedHour
    self._meridiem = meridiem
    self.feedbackGenerator.prepare()
  }
  
  public var body: some View {
    GeometryReader { geometry in
      let radius = min(geometry.size.width, geometry.size.height) / 2 * 0.8
      
      ZStack {
        
        LinearGradient(
          gradient: Gradient(
            colors: [
              Theme.from(meridiem: meridiem, hour: selectedHour).startColor,
              Theme.from(meridiem: meridiem, hour: selectedHour).endColor
            ]
          ),
          startPoint: .trailing,
          endPoint: .leading
        )
        .animation(.easeInOut(duration: 0.5), value: selectedHour)
        .animation(.easeInOut(duration: 0.5), value: meridiem)
        
        Rectangle()
          .fill(Gen.Colors.black.color)
          .frame(width: 2, height: radius)
          .offset(y: -radius / 2)
          .rotationEffect(angle)
        
        Circle()
          .fill(Gen.Colors.black.color)
          .frame(width: 8, height: 8)
          .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        
        hourView()
      }
      .frame(width: geometry.size.width, height: geometry.size.height)
      .gesture(
        DragGesture()
          .onChanged { value in
            let vector = CGVector(dx: value.location.x - geometry.size.width / 2, dy: value.location.y - geometry.size.height / 2)
            let radians = atan2(vector.dy, vector.dx)
            let degrees = radians * 180 / .pi
            let adjustedDegrees = (degrees + 60).truncatingRemainder(dividingBy: 360)
            let hour = ((Int(adjustedDegrees) + 15) / 30) % 12 + 1
            self.angle = Angle(degrees: Double(hour) * 30)
            self.selectedHour = {
              if hour > 0 {
                return hour
              } else {
                return hour + 12
              }
            }()
          }
      )
      .clipShape(.circle)
    }
    .onAppear {
      angle = Angle(degrees: Double(selectedHour) * 30)
    }
    .onChange(of: selectedHour) { _, _ in
      self.feedbackGenerator.impactOccurred()
    }
  }
  
  // MARK: - private method
  
  @ViewBuilder
  private func hourView() -> some View {
    GeometryReader { geometry in
      let radius = min(geometry.size.width, geometry.size.height) / 2 * 0.8
      ForEach(hours, id: \.self) { hour in
        let hourAngle = Angle(degrees: (Double(hour) / 12.0) * 360.0)
        let x = cos(hourAngle.radians - .pi / 2) * radius
        let y = sin(hourAngle.radians - .pi / 2) * radius
        
        Button(action: {
          let currentAngle = angle.degrees
          let targetAngle = Double(hour) * 30
          withAnimation(.easeInOut) {
            if targetAngle > currentAngle {
              angle = Angle(degrees: targetAngle)
            } else {
              angle = Angle(degrees: targetAngle + 360)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
              angle = Angle(degrees: targetAngle)
              selectedHour = hour
            }
          }
        }, label: {
          ZStack {
            Circle()
              .foregroundStyle(selectedHour == hour ? Gen.Colors.black.color : .clear)
              .frame(width: 30, height: 30)
            Text("\(hour)")
              .font(.fonts(.body16))
              .foregroundStyle(Gen.Colors.white.color)
          }
        })
        .position(x: geometry.size.width / 2 + x, y: geometry.size.height / 2 + y)
      }
    }
  }
  
  // MARK: - public method
  
}
