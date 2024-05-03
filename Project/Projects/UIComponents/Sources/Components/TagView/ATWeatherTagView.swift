//
//  ATWeatherTagView.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 4/23/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI

public struct ATWeatherTagView: View {
  
  public enum Weather {
    case cloudy
    
    var icon: Image {
      switch self {
      case .cloudy:
        return Gen.Images.cloudy.image
      }
    }
  }
  
  // MARK: - public state
  
  // MARK: - private properties
  
  private let designType: ATTagView.DesignType
  private let weather: Weather
  private let temperature: Float
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  public var body: some View {
    
    ATTagView(
      designType: self.designType,
      icon: self.weather.icon,
      title: "\(String(format: "%.1f", self.temperature))°C"
    )
    
  }
  
  public init(
    designType: ATTagView.DesignType = .primary,
    weather: Weather,
    temperature: Float
  ) {
    self.designType = designType
    self.weather = weather
    self.temperature = temperature
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
}

#Preview {
  VStack {
    ATTagView(icon: Image(systemName: "bolt"), title: "hola")
  }
  
}
