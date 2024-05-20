//
//  ContentView.swift
//  ArchiveFoundation
//
//  Created by hanwe on 1/28/24.
//  Copyright © 2024 Archive. All rights reserved.
//

import SwiftUI
import UIComponents

struct ContentView: View {
  
  @State var isToggleOn: Bool = false {
    didSet {
      print("isToggleOn: \(self.isToggleOn)")
    }
  }
  
  var body: some View {
    ZStack {
      ATBackgroundView()
        .edgesIgnoringSafeArea(.all)
      ScrollView {
        VStack {
          ATNavigationBar(
            type: .default(title: "새로운 사진",
                           trailingIcon: Gen.Images.refresh24.image,
                           backAction: {
                             print("ATNavigationBar Back Action")
                           }, trailingAction: {
                             print("ATNavigationBar Trailing Action")
                           }))
          ATDivider(type: .small)
          ATDivider(type: .medium)
          ATDivider(type: .large)
          ATInputView(placeholder: "텍스트 입력하기")
          ATGradientView(type: .main, direction: .horizontal)
            .frame(height: 44)
          ATGradientView(type: .morning, direction: .horizontal)
            .frame(height: 44)
          ATGradientView(type: .afternoon, direction: .horizontal)
            .frame(height: 44)
          ATGradientView(type: .evening, direction: .horizontal)
            .frame(height: 44)
          ATGradientView(type: .night, direction: .horizontal)
            .frame(height: 44)
          ATBadge(text: "99")
          ATToast(icon: .check, message: "사진 업로드가 완료되었습니다.")
          ATTooltip(title: "Be the first to share the news!")

          ATSignInButton(type: .apple, action: {
            print("apple")
          })
          ATButton(title: "hola", action: {
            print("Button")
          })
          ATButton(title: "hola", action: {
            print("Button")
          }, isEnabled: .constant(false))
          ATBottomButton(title: "ATBottomButton", action: {
            print("Button")
          })
          ATBottomButton(title: "ATBottomButton", action: {
            print("Button")
          }, isEnabled: .constant(false))
          ATBottomActionButton(icon: Gen.Images.send24.image, title: "ATBottomActionButton", action: {
            print("Button")
          })
          ATBottomActionButton(icon: .init(systemName: "bolt"), title: "ATBottomActionButton", action: {
            print("Button")
          }, isEnabled: .constant(false))
          ATRoundIconButton(
            icon: Gen.Images.plus.image,
            borderColor: .white,
            borderWidth: 2,
            iconSizeType: .constant(.init(
              width: 18,
              height: 18
            )), action: {
              print("Button")
            })
          .frame(width: 62, height: 62)
          ATRoundIconButton(
            icon: Gen.Images.plus.image,
            borderColor: .white,
            borderWidth: 2,
            iconSizeType: .constant(.init(
              width: 18,
              height: 18
            )),
            action: {
              print("Button")
            }, isEnabled: .constant(false))
          .frame(width: 62, height: 62)
          ATRoundIconButton(
            icon: Gen.Images.send24.image,
            backgroundColor: Gen.Colors.purpleGray400.color,
            action: {
              print("Button")
            }
          )
          .frame(width: 44, height: 44)
          ATRoundIconButton(
            icon: Gen.Images.send24.image,
            backgroundColor: Gen.Colors.purpleGray200.color,
            action: {
              print("Button")
            }
          )
          .frame(width: 40, height: 30)
          ATSelectableButton(contentsView: Text("ATSelectableButton"), action: { isSelected in
            print("Button: \(isSelected)")
          })
          ATSelectableEmojiButton(
            emoji: .heart,
            selectedCount: 100,
            isSelected: true,
            action: { isSelected, count in
              print("Button: \(isSelected) \(count)")
            }
          )
          Toggle("", isOn: $isToggleOn)
            .toggleStyle(ATToggleStyle(
              onColor: Gen.Colors.purple.color,
              offColor: Gen.Colors.gray200.color,
              onThumbColor: Gen.Colors.white.color,
              offThumbColor: Gen.Colors.white.color
            ))
          ATTagView(icon: .init(systemName: "bolt"), title: "ATTagView")
          ATTagView(icon: nil, title: "ATTagView")
          ATWeatherTagView(weather: .cloudy, temperature: 5.5)
          ATWeatherTagView(designType: .secondary, weather: .cloudy, temperature: 5.5)
          ATDateTagView(date: Date())
          ATSegmentedDynamicControlView(segmentTitleList: ["Test11111111", "Test2"])
          ATSegmentedStaticControlView(segmentItemList: [
            .init(icon: .init(systemName: "bolt"), title: "Bolt"),
            .init(icon: .init(systemName: "heart"), title: "Heart")
          ])
          ATCheckBoxView(title: "ATCheckBoxView", isChecked: false, action: { isChecked in
            print("isChecked: \(isChecked)")
          })
          ATUrlImage(
            url: URL(string: "https://hips.hearstapps.com/hmg-prod/images/little-cute-maltipoo-puppy-royalty-free-image-1652926025.jpg?crop=0.444xw:1.00xh;0.129xw,0&resize=980:*")!,
            placeholder: .init(systemName: "bolt")
          )
          .resizable()
          .scaledToFill()
          .frame(width: 100, height: 100)
          .clipped()
          ATCheckImageButton(
            type: .url(
              url: URL(string: "https://hips.hearstapps.com/hmg-prod/images/little-cute-maltipoo-puppy-royalty-free-image-1652926025.jpg?crop=0.444xw:1.00xh;0.129xw,0&resize=980:*")!,
              placeholder: .init(systemName: "bolt")
            ),
            isChecked: false,
            action: { isChecked in
              print("ATCheckImageButton: \(isChecked)")
            }
          )
          .frame(width: 68, height: 68)
          ATCheckImageButton(
            type: .image(.init(systemName: "bolt")),
            isChecked: true,
            action: { isChecked in
              print("ATCheckImageButton: \(isChecked)")
            }
          )
          .frame(width: 68, height: 68)
          PageIndicator(numberOfPages: 10, currentPage: .constant(1))
        }
      }
    }
  }
}

#Preview {
  ContentView()
}


