//
//  AppstoreSearchView.swift
//  AppstoreSearch
//
//  Created by Aaron Hanwe LEE on 1/31/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import SwiftUI
import ComposableArchitecture


struct AppstoreSearchView: View {
  
  // MARK: - Private Property
  
  private let store: Store<AppstoreSearchReducer.State, AppstoreSearchReducer.Action>
  
  // MARK: - Internal Property
  
  // MARK: - Sub UI Component
  
  // MARK: - Body
  
  var body: some View {
    
    WithViewStore(store, observe: { $0 }) { viewStore in
      //      ZStack {
      //        VStack {
      //          Spacer()
      //
      //          VStack {
      //            Image(nsImage: Gen.Images.splash.image)
      //              .imageScale(.large)
      //              .padding(14)
      //            Image(nsImage: Gen.Images.splashText.image)
      //              .imageScale(.large)
      //          }
      //
      //          Spacer()
      //          VStack(spacing: 8) {
      //
      //            SignInButton(title: "Sign in with Apple", iconImage: Image(nsImage: Gen.Images.appleLogo.image), action: {
      //              viewStore.send(.signInWithApple)
      //            })
      //            .frame(height: 36)
      //
      //            SignInButton(title: "Sign in with Google", iconImage: Image(nsImage: Gen.Images.googleLogo.image), action: {
      //              viewStore.send(.signInWithGoogle)
      //            })
      //            .frame(height: 36)
      //
      //
      //            SignInButton(title: "Sign in with Facebook", iconImage: Image(nsImage: Gen.Images.facebook.image), action: {
      //              viewStore.send(.signInWithFacebook)
      //            })
      //            .frame(height: 36)
      //
      //
      //            SignInButton(title: "Sign in with Wechat", iconImage: Image(nsImage: Gen.Images.wechatLogo.image), action: {
      //              viewStore.send(.signInWithWechat)
      //            })
      //            .frame(height: 36)
      //
      //          }
      //        }
      //        .padding()
      //
      //          ProgressView()
      //            .opacity(viewStore.state.isLoading ? 1 : 0)
      //
      //        }
    }
  }
  
  
  // MARK: - Life Cycle
  
//  init(reducer: AppstoreSearchReducer) {
////    //    self.store = .init(initialState: .init(), reducer: reducer)
//    self.store = .init(initialState: .init(), reducer: reducer)
//  }
  
  // MARK: - Private Method
  
  // MARK: - Internal Method
  
}


