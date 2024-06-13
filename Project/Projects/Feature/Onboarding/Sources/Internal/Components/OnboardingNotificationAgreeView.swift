//
//  OnboardingNotificationAgreeView.swift
//  Onboarding
//
//  Created by Aaron Hanwe LEE on 6/12/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import UIComponents
import ArchiveFoundation
import ComposableArchitecture

struct OnboardingNotificationAgreeView: View {
  
  // MARK: - internal state
  
  // MARK: - private properties
  
  private var completeAction: () -> Void
  @Binding var contentsHeight: CGFloat
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  init(
    contentsHeight: Binding<CGFloat>,
    completeAction: @escaping () -> Void
  ) {
    self._contentsHeight = contentsHeight
    self.completeAction = completeAction
  }
  
  var body: some View {
    ZStack {
      Gen.Colors.purpleGray400.color
        .ignoresSafeArea(.all)
      VStack(spacing: 0) {
        
        VStack(spacing: 20) {
          HStack {
            Spacer()
            Button(action: {
              completeAction()
            }, label: {
              Text(L10n.Localizable.commonSkip)
                .font(.fonts(.buttonExtraBold14))
                .foregroundStyle(Gen.Colors.gray200.color)
            })
          }
          VStack {
            Text(L10n.Localizable.onboardingNotiContents) // 개행이 있음
              .font(.fonts(.body16))
              .foregroundStyle(Gen.Colors.white.color)
              .lineLimit(nil)
              .multilineTextAlignment(.center)
              .layoutPriority(1)
          }
        }
        .padding(.designContentsSideInsets)
        
        
        notiHelpImage()
          .padding(.top, 40)
        
        ATBottomActionButton(
          designType: .secondary,
          title: L10n.Localizable.commonAgree,
          action: {
            print("ㅇㅇ")
          },
          isEnabled: .constant(true)
        )
        
      }
      .padding(
        .init(
          top: 40,
          leading: .designContentsInset,
          bottom: 0,
          trailing: .designContentsInset
        )
      )
      .background(GeometryReader { geometry in
        Color.clear
          .onAppear {
            DispatchQueue.main.async {
              contentsHeight = geometry.size.height
            }
          }
      })
    }
  }
  
  // MARK: - private method
  
  private func notiHelpImage() -> Image {
    let preferredLanguage = Locale.preferredLanguages.first ?? "en"
    if preferredLanguage == "ko" {
      return Gen.Images.onboardingNotiKr.image
    } else {
      return Gen.Images.onboardingNotiEn.image
    }
  }
  
  // MARK: - internal method
  
}
