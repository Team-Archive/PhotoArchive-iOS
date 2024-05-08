//
//  AlbumView.swift
//  Album
//
//  Created by hanwe on 5/1/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import Domain

public struct AppstoreSearchView: View {
  
  // MARK: - Private Property
  
//  private let store: Store<AppstoreSearchReducer.State, AppstoreSearchReducer.Action>
  private let store: StoreOf<AlbumReducer> // 위에 주석처리된 문법의 축약형
  @State var text: String = ""
  
  // MARK: - Internal Property
  
  // MARK: - Sub UI Component
  
  // MARK: - Body
  
  public var body: some View {
    
    WithViewStore(store, observe: { $0 }) { viewStore in
      ZStack {
        VStack {
          VStack(spacing: 8) {
            TextField("텍스트 입력", text: $text)
              .onSubmit {
                self.store.send(.search(keyword: text))
              }
            List(viewStore.appList) { app in
              Text(app.name)
            }
          }
          .navigationTitle("앱 목록")
        }
        .padding()
        
        ProgressView()
          .opacity(viewStore.state.isLoading ? 1 : 0)
        
      }
    }
  }
  
  // MARK: - Life Cycle
  
  public init(reducer: AlbumReducer) {
    self.store = .init(initialState: .init(), reducer: {
      return reducer
    })
  }
  
  // MARK: - Private Method
  
  // MARK: - Internal Method
  
}
