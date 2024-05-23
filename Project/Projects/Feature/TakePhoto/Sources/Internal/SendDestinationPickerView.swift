//
//  SendDestinationPickerView.swift
//  TakePhoto
//
//  Created by Aaron Hanwe LEE on 5/23/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import UIComponents
import ArchiveFoundation

struct SendDestinationPickerView: View {
  
  enum PickItemType {
    case allFriends
    case friends(UserInformation)
    
    var name: String {
      switch self {
      case .allFriends:
        return L10n.Localizable.takePhotoSendToAllButtonTitle
      case .friends(let info):
        return info.name
      }
    }
  }
  
  // MARK: - public state
  
  // MARK: - private properties
  
  private let candidateList: [UserInformation]
  @State private var selectedList: Set<UserInformation> = .init()
  @State private var isSelectedSendToAllFriends: Bool = false
  @State private var isConfirmButtonEnabled: Bool = false
  private let itemInset: CGFloat = 16
  
  // MARK: - public properties
  
  var action: (Set<UserInformation>) -> Void
  
  // MARK: - life cycle
  
  var body: some View {
    ZStack {
      Gen.Colors.purpleGray400.color
        .ignoresSafeArea(.all)
      VStack(spacing: 12) {
        Text(L10n.Localizable.takePhotoSendToTitle)
          .font(.fonts(.body16))
          .foregroundStyle(Gen.Colors.white.color)
          .padding(.top, 20)
        ContentsView()
      }
      VStack {
        Spacer()
        ATBottomActionButton(
          icon: Gen.Images.send24.image,
          title: L10n.Localizable.takePhotoSendToButtonTitle,
          action: {
            if self.isSelectedSendToAllFriends {
              self.action(Set<UserInformation>(self.candidateList))
            } else {
              self.action(self.selectedList)
            }
          },
          isEnabled: $isConfirmButtonEnabled
        )
      }
    }
  }
  
  init(
    candidateList: [UserInformation],
    action: @escaping (Set<UserInformation>) -> Void
  ) {
    self.candidateList = candidateList
    self.action = action
  }
  
  // MARK: - private method
  
  @ViewBuilder
  private func ContentsView() -> some View {
    GeometryReader { geometry in
      ScrollView {
        let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: self.itemInset), count: 4)
        LazyVGrid(columns: columns, spacing: self.itemInset) {
          UserView(
            info: .allFriends,
            index: 0,
            buttonSize: .init(
              width: (geometry.size.width - (.designContentsInset * 2) - (self.itemInset * 3)) / 4,
              height: (geometry.size.width - (.designContentsInset * 2) - (self.itemInset * 3)) / 4
            )
          )
          ForEach(0..<candidateList.count, id: \.self) { index in
            if let item = self.candidateList[safe: index] {
              UserView(
                info: .friends(item),
                index: UInt(index + 1),
                buttonSize: .init(
                  width: (geometry.size.width - (.designContentsInset * 2) - (self.itemInset * 3)) / 4,
                  height: (geometry.size.width - (.designContentsInset * 2) - (self.itemInset * 3)) / 4
                )
              )
            }
          }
        }.padding(.bottom, 60)
      }
      .padding(
        .init(
          top: 0,
          leading: .designContentsInset,
          bottom: 0,
          trailing: .designContentsInset
        )
      )
    }
  }
  
  @ViewBuilder
  private func UserView( // TODO: 선택시 아이콘 영역이 뷰 영역을 넘어버림. 수정해야함
    info: PickItemType,
    index: UInt,
    buttonSize: CGSize
  ) -> some View {
    VStack(alignment: .center, spacing: 4) {
      switch info {
      case .allFriends:
        ATCheckImageButton(
          type: .image(Gen.Images.user24.image),
          isHapticEnable: true,
          isChecked: self.$isSelectedSendToAllFriends,
          action: { isSelected in
            self.selectedList.removeAll()
            if isSelected {
              self.isSelectedSendToAllFriends = true
            } else {
              self.isSelectedSendToAllFriends = false
            }
            self.isConfirmButtonEnabled = self.isConfirmButtonEnabledState()
          }
        )
        .frame(
          width: buttonSize.width,
          height: buttonSize.height
        )
      case .friends(let userInfo):
        ATCheckImageButton(
          type: .url(
            url: userInfo.profileSmallUrl,
            placeholder: Gen.Images.placeholderMini.image
          ),
          isHapticEnable: true,
          isChecked: Binding<Bool>(
            get: { self.selectedList.contains(userInfo) },
            set: { _ in }
          ),
          action: { isSelected in
            if self.isSelectedSendToAllFriends {
              self.isSelectedSendToAllFriends = false
            }
            if isSelected {
              self.selectedList.remove(userInfo)
            } else {
              self.selectedList.insert(userInfo)
            }
            self.isConfirmButtonEnabled = self.isConfirmButtonEnabledState()
          }
        )
        .frame(
          width: buttonSize.width,
          height: buttonSize.height
        )
      }
      Text(info.name)
        .font(.fonts(.bodyBold14))
        .foregroundStyle(Gen.Colors.white.color)
        .multilineTextAlignment(.center)
    }
    .frame(
      width: buttonSize.width,
      height: buttonSize.height + 40,
      alignment: .top
    )
    
  }
  
  private func isConfirmButtonEnabledState() -> Bool {
    if self.isSelectedSendToAllFriends {
      return true
    } else {
      return self.selectedList.count > 0
    }
  }
  
  // MARK: - internal method
  
}

#Preview {
  VStack {
    SendDestinationPickerView(candidateList: []) { list in
      print("selected: \(list)")
    }
  }
  
}
