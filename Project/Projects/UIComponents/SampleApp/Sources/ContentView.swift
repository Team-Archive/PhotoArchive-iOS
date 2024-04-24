//
//  ContentView.swift
//  ArchiveFoundation
//
//  Created by hanwe on 1/28/24.
//  Copyright © 2024 Archive. All rights reserved.
//

import SwiftUI
import UIComponents

struct ContentView: View {
  
  @State var isToggleOn: Bool = false {
    didSet {
      print("isToggleOn: \(self.isToggleOn)")
    }
  }
  
  var body: some View {
    ScrollView {
      VStack {
        ATSignInButton(type: .apple, action: {
          print("apple")
        })
        ATButton(title: "hola", action: {
          print("Button")
        })
        ATButton(title: "hola", action: {
          print("Button")
        }, isEnabled: .constant(false))
        ATBottomButton(title: "hola", action: {
          print("Button")
        })
        ATBottomButton(title: "hola", action: {
          print("Button")
        }, isEnabled: .constant(false))
        ATBottomActionButton(icon: UIComponentsAsset.Images.send24.swiftUIImage, title: "hola", action: {
          print("Button")
        })
        ATBottomActionButton(icon: .init(systemName: "bolt"), title: "hola", action: {
          print("Button")
        }, isEnabled: .constant(false))
        ATRoundIconButton(icon: UIComponentsAsset.Images.plus.swiftUIImage, borderColor: .white, borderWidth: 2, action: {
          print("Button")
        })
        .frame(width: 62, height: 62)
        ATRoundIconButton(icon: UIComponentsAsset.Images.plus.swiftUIImage, borderColor: .white, borderWidth: 2, action: {
          print("Button")
        }, isEnabled: .constant(false))
        .frame(width: 62, height: 62)
        Toggle("", isOn: $isToggleOn)
          .toggleStyle(ATToggleStyle(
            onColor: UIComponentsAsset.Colors.purple.swiftUIColor,
            offColor: UIComponentsAsset.Colors.gray200.swiftUIColor,
            onThumbColor: UIComponentsAsset.Colors.white.swiftUIColor,
            offThumbColor: UIComponentsAsset.Colors.white.swiftUIColor
          ))
        ATTagView(icon: .init(systemName: "bolt"), title: "hola")
        ATTagView(icon: nil, title: "hola")
        ATWeatherTagView(weather: .cloudy, temperature: 5.5)
        ATWeatherTagView(designType: .secondary, weather: .cloudy, temperature: 5.5)
        ATDateTagView(date: Date())
        ATSegmentedDynamicControlView(segmentTitleList: ["Test11111111", "Test2"])
        ATSegmentedStaticControlView(segmentItemList: [
          .init(icon: .init(systemName: "bolt"), title: "Bolt"),
          .init(icon: .init(systemName: "heart"), title: "Heart")
        ])
        ATCheckBoxView(title: "hola", isChecked: false)
      }
    }
    .background(.gray)
  }
}

#Preview {
  ContentView()
}


