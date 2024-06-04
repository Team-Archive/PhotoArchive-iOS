//
//  SignUpSetProfileView.swift
//  SignUp
//
//  Created by hanwe on 5/25/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import UIComponents
import ArchiveFoundation
import ComposableArchitecture

struct SignUpSetProfileView: View, SignUpStepView {
  
  // MARK: - internal state
  
  // MARK: - private properties
  
  private let store: StoreOf<SignUpReducer>
  private var nextAction: () -> Void
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  init(
    store: StoreOf<SignUpReducer>,
    nextAction: @escaping () -> Void
  ) {
    self.nextAction = nextAction
    self.store = store
  }
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      ZStack {
        Gen.Colors.backgroundSignUp.color
          .ignoresSafeArea(.all)
        VStack(alignment: .center) {
          
          HStack {
            Text(L10n.Localizable.signUpSetProfileTitle)
              .font(.fonts(.title24))
              .foregroundStyle(Gen.Colors.white.color)
              .padding(
                .init(
                  top: 28,
                  leading: .designContentsInset,
                  bottom: 0,
                  trailing: .designContentsInset
                )
              )
            Spacer()
          }
          
          HStack {
            Text(L10n.Localizable.signUpSetProfileContents)
              .font(.fonts(.body14))
              .foregroundStyle(Gen.Colors.gray300.color)
              .padding(
                .init(
                  top: 4,
                  leading: .designContentsInset,
                  bottom: 0,
                  trailing: .designContentsInset
                )
              )
            Spacer()
          }
          
          
          Button(action: {
            print("사진선택하기")
          }, label: {
            ATPHAssetImage(
              asset: nil,
              placeholder: Gen.Images.setProfilePlaceholder.image
            )
            .resizable()
            .frame(width: 160, height: 160)
            .padding(
              .init(
                top: 12,
                leading: .designContentsInset,
                bottom: 0,
                trailing: .designContentsInset
              )
            )
          })
          
          ATUnderlineInputView(
            placeholderMessage: L10n.Localizable.signUpSetProfilePlaceholder,
            message: Binding(get: { viewStore.nicknameCandidate }, set: { text in viewStore.send(.setNickname(text)) }),
            isValidMessage: Binding(get: { viewStore.isValidNickname != .invalid(.duplicated) }, set: { _ in }),
            submitLabel: .done,
            maxLength: viewStore.nicknameMaxLength
          )
          .onDebouncedChange(of: viewStore.nicknameCandidate, debounceTime: 0.4, perform: { nicknameCandidate in
            viewStore.send(.checkValidateNickname(nicknameCandidate))
          })
          .padding(
            .init(
              top: 32,
              leading: .designContentsInset,
              bottom: 0,
              trailing: .designContentsInset
            )
          )
          
          HelpView()
            .frame(height: 14)
            .padding(
              .init(
                top: 4,
                leading: .designContentsInset,
                bottom: 0,
                trailing: .designContentsInset
              )
            )
          
          Spacer()
          ATBottomActionButton(
            designType: .secondary,
            title: L10n.Localizable.commonNext,
            action: {
              nextAction()
            },
            isEnabled: Binding(get: { viewStore.isValidNickname == .valid }, set: { _ in })
          )
          .padding(.bottom, 20)
          
        }
      }
    }
  }
  
  // MARK: - private method
  
  @ViewBuilder
  private func HelpView() -> some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      HStack {
        switch viewStore.isValidNickname {
        case .valid:
          Spacer()
        case .invalid(let reason):
          let contents: String = {
            switch reason {
            case .duplicated:
              return L10n.Localizable.signUpSetProfileNicknameDuplicated
            case .overLength:
              return L10n.Localizable.signUpSetProfileNicknameOverLength
            default:
              return ""
            }
          }()
          Text(contents)
            .font(.fonts(.body14))
            .foregroundStyle(Gen.Colors.red.color)
        }
        Spacer()
        Text("(\(viewStore.nicknameCandidate.count)/\(viewStore.nicknameMaxLength))")
          .font(.fonts(.body14))
          .foregroundStyle(viewStore.isValidNickname != .invalid(.overLength) ? Gen.Colors.purpleGray50.color : Gen.Colors.red.color)
      }
    }
  }
  
  // MARK: - internal method
  
}
