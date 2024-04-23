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
      }
    }
    .background(.gray)
  }
}

#Preview {
  ContentView()
}
