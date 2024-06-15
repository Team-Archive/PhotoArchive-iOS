//
//  ATWatchTimeSelectorView.swift
//  UIComponents
//
//  Created by hanwe on 6/15/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI

public struct ATWatchTimeSelectorView: View {
  @State private var selectedHour: Int = 12
  
  public var body: some View {
    VStack {
      Text("\(selectedHour)시")
        .font(.largeTitle)
        .padding()
      
      ClockWheelView(selectedHour: $selectedHour)
        .frame(width: 300, height: 300)
        .padding()
    }
  }
  
  public init(selectedHour: Int) {
    self.selectedHour = selectedHour
  }
}

public struct ClockWheelView: View {
  
  // MARK: - private property
  
  @Binding private var selectedHour: Int
  @State private var angle: Angle = .degrees(0)
  private let hours = Array(1...12)
  private let feedbackGenerator: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
  
  // MARK: - internal property
  
  // MARK: - lifeCycle
  
  init(selectedHour: Binding<Int>) {
    self._selectedHour = selectedHour
    self.feedbackGenerator.prepare()
  }
  
  public var body: some View {
    GeometryReader { geometry in
      let radius = min(geometry.size.width, geometry.size.height) / 2 * 0.8
      
      ZStack {
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
            self.feedbackGenerator.impactOccurred()
            self.selectedHour = {
              if hour > 0 {
                return hour
              } else {
                return hour + 12
              }
            }()
          }
      )
    }
    .onAppear {
      angle = Angle(degrees: Double(selectedHour) * 30)
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
          Text("\(hour)")
            .font(.fonts(.body16))
            .foregroundStyle(Gen.Colors.white.color)
        })
        .position(x: geometry.size.width / 2 + x, y: geometry.size.height / 2 + y)
      }
    }
  }
  
  // MARK: - public method
  
  
  
  
}
