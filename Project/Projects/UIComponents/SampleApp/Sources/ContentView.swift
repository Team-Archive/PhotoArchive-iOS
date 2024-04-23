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
      }
    }
    .background(.gray)
  }
}

#Preview {
  ContentView()
}
