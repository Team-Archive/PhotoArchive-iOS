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
    VStack {
      ATSignInButton(type: .apple, action: {
        print("apple")
      })
      ATButton(type: .primary, title: "hola", action: {
        print("Button")
      })
    }
  }
}

#Preview {
  ContentView()
}
