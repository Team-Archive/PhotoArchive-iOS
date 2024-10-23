//
//  OnboardingTermsView.swift
//  Onboarding
//
//  Created by Aaron Hanwe LEE on 6/12/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import UIComponents
import ArchiveFoundation
import ComposableArchitecture

struct OnboardingTermsView: View {
  
  // MARK: - internal state
  
  // MARK: - private properties
  
  private var completeAction: () -> Void
  @State private var isAgreeTerms: Bool = false
  @State private var isAgreePrivacy: Bool = false
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
        Text(L10n.Localizable.onboardingTermsTitle)
          .font(.fonts(.title20))
          .foregroundStyle(Gen.Colors.white.color)
          .padding(.bottom, 40)
        ContentsView()
        ATBottomActionButton(
          designType: .secondary,
          title: L10n.Localizable.commonAgree,
          action: {
            completeAction()
          },
          isEnabled: Binding(get: { self.isAgreeTerms && self.isAgreePrivacy }, set: { _ in })
        )
        .padding(.top, 40)
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
  
  @ViewBuilder
  private func ContentsView() -> some View {
    VStack(spacing: 20) {
      HStack(spacing: 12) {
        ATCheckBoxView(
          title: nil,
          isChecked: Binding(get: { self.isAgreeTerms && self.isAgreePrivacy }, set: { _ in }),
          action: { isChecked in
            self.isAgreeTerms = !isChecked
            self.isAgreePrivacy = !isChecked
          }
        )
        Text(L10n.Localizable.onboardingTermsMenuAllAgree)
          .font(.fonts(.bodyBold14))
          .foregroundStyle(Gen.Colors.white.color)
        Spacer()
      }
      ATDivider(type: .extreamSmall)
      HStack(spacing: 12) {
        ATCheckBoxView(
          title: nil,
          isChecked: Binding(get: { self.isAgreeTerms }, set: { _ in }),
          action: { isChecked in
            self.isAgreeTerms.toggle()
          }
        )
        Button(action: {
          print("약관보기")
        }, label: {
          HStack(spacing: 4) {
            Text(L10n.Localizable.onboardingTermsMenuTerms)
              .font(.fonts(.body14))
              .foregroundStyle(Gen.Colors.white.color)
            Text("(\(L10n.Localizable.commonRequired))")
              .font(.fonts(.body14))
              .foregroundStyle(Gen.Colors.purple.color)
            Spacer()
            Gen.Images.arrowMini.image
          }
        })
      }
      HStack(spacing: 12) {
        ATCheckBoxView(
          title: nil,
          isChecked: Binding(get: { self.isAgreePrivacy }, set: { _ in }),
          action: { isChecked in
            self.isAgreePrivacy.toggle()
          }
        )
        Button(action: {
          print("개인정보처리방침 보기")
        }, label: {
          HStack(spacing: 4) {
            Text(L10n.Localizable.onboardingTermsMenuPrivacy)
              .font(.fonts(.body14))
              .foregroundStyle(Gen.Colors.white.color)
            Text("(\(L10n.Localizable.commonRequired))")
              .font(.fonts(.body14))
              .foregroundStyle(Gen.Colors.purple.color)
            Spacer()
            Gen.Images.arrowMini.image
          }
        })
      }
    }
  }
  
  // MARK: - internal method
  
}
