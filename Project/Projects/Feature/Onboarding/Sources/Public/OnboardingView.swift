//
//  OnboardingView.swift
//  OnboardingView
//
//  Created by Aaron Hanwe LEE on 1/29/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import ArchiveFoundation
import UIComponents
import AppRoute

// swiftlint:disable:next generic_type_name
public struct OnboardingView<ServiceSignInDelegatorView>: View where ServiceSignInDelegatorView: ServiceSignInDelegator {
  
  // MARK: - Private Property
  
  private let store: StoreOf<OnboardingReducer>
  @State private var termsViewHeight: CGFloat = 0
  @State private var notificationAgreeViewHeight: CGFloat = 0
  @State private var isShowNotificationAgree: Bool = false
  
  // MARK: - Internal Property
  
  // MARK: - Life Cycle
  
  public init(
    reducer: OnboardingReducer
  ) {
    self.store = .init(initialState: reducer.initialState, reducer: {
      return reducer
    })
  }
  
  public var body: some View {
    
    WithViewStore(store, observe: { $0 }) { viewStore in
      ZStack {
        ATBackgroundView()
          .ignoresSafeArea(.all)
        VStack {
          Spacer()
          Spacer()
          Spacer()
          
          Gen.Images.logo.image
          
          Spacer()
          Spacer()
          Spacer()
          
          VStack(spacing: 16) {
            ATSignInButton(type: .apple, action: {
              viewStore.send(.action(.oauthSignIn(.apple)))
            })
            ATSignInButton(type: .google, action: {
              viewStore.send(.action(.oauthSignIn(.google)))
            })
            ATSignInButton(type: .facebook, action: {
              viewStore.send(.action(.oauthSignIn(.facebook)))
            })
          }
          .padding(.designContentsSideInsets)
          
          Spacer()
        }
        .sheet(isPresented: viewStore.binding(
          get: { $0.isShowTerms },
          send: { _ in OnboardingReducer.Action.action(.closeTerms) })
        ) {
          OnboardingTermsView(
            contentsHeight: self.$termsViewHeight,
            completeAction: {
              viewStore.send(.action(.agreeAllTerms))
          })
          .presentationDetents([.height(self.termsViewHeight)])
          .onDisappear {
            if viewStore.isAllTermsAgree {
              switch viewStore.notificationStatus {
              case .authorized:
                viewStore.send(.action(.doneNotificationAgree))
              default:
                isShowNotificationAgree = true
              }
            }
          }
        }
        .sheet(isPresented: $isShowNotificationAgree
        ) {
          OnboardingNotificationAgreeView(
            contentsHeight: self.$notificationAgreeViewHeight,
            completeAction: {
              isShowNotificationAgree = false
              viewStore.send(.action(.doneNotificationAgree))
          })
          .presentationDetents([.height(self.notificationAgreeViewHeight + 22)])
        }
        .fullScreenCover(isPresented: viewStore.binding(
          get: { $0.isShowSignUp },
          send: { _ in OnboardingReducer.Action.action(.closeSignUp) })) {
            ServiceSignInDelegatorView(
              oauthSignInData: .apple(token: ""), // TODO: 적절한거 넣어야함
              completeAction: { token in
                viewStore.send(.action(.setServiceSignInToken(token)))
              },
              closeAction: {
                viewStore.send(.action(.closeSignUp))
              }
            )
        }
        
        if viewStore.isLoading {
          ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: Gen.Colors.white.color))
            .scaleEffect(1.5)
        }
      }
    }
    
  }
  
  // MARK: - Private Method
  
  // MARK: - Internal Method
  
}
