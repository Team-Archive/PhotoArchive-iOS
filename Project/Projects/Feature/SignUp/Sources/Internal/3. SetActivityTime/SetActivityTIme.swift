//
//  SetActivityTIme.swift
//  SignUp
//
//  Created by hanwe on 5/26/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import UIComponents
import ArchiveFoundation
import ComposableArchitecture

struct SetActivityTIme: View {
  
  // MARK: - internal state
  
  // MARK: - private properties
  
  private let store: StoreOf<SignUpReducer>
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  init(store: StoreOf<SignUpReducer>) {
    self.store = store
  }
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      Text("SetActivityTIme")
    }
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
}
