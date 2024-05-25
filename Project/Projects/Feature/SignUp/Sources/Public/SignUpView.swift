//
//  SignUpView.swift
//  SignUp
//
//  Created by hanwe on 5/25/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import ArchiveFoundation
import UIComponents

public struct SignUpView: View {
  
  // MARK: - Private Property
  
  private let store: StoreOf<SignUpReducer>
  @State private var stackPath: NavigationPath = .init()
  
  // MARK: - Internal Property
  
  // MARK: - Life Cycle
  
  public init(
    reducer: SignUpReducer
  ) {
    self.store = .init(initialState: .init(), reducer: {
      return reducer
    })
  }
  
  public var body: some View {
    
    WithViewStore(store, observe: { $0 }) { viewStore in
      NavigationStack(path: $stackPath) {
        
      }
    }
  }
  
  // MARK: - Private Method
  
  // MARK: - Internal Method
  
}
