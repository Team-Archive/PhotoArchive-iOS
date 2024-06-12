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
      ZStack {
        ATBackgroundView()
          .ignoresSafeArea(.all)
        VStack(spacing: 0) {
          SignUpFakeNavigationView(requestBackAction: {
            print("뒤로가기 요청")
          })
          .frame(height: 56)
          SignUpProgressView()
            .frame(height: 4)
          NavigationStack(path: $stackPath) {
            SignUpSetCityView(store: self.store)
          }
        }
      }
    }
    
  }
  
  // MARK: - Private Method
  
  // MARK: - Internal Method
  
}
