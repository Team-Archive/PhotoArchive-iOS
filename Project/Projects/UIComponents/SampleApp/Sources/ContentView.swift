//
//  ContentView.swift
//  ArchiveFoundation
//
//  Created by hanwe on 1/28/24.
//  Copyright © 2024 Archive. All rights reserved.
//

import SwiftUI
import UIComponents
import Lottie

struct ContentView: View {
  
  @State var isToggleOn: Bool = false {
    didSet {
      print("isToggleOn: \(self.isToggleOn)")
    }
  }
  
  @State var isSelectedOn: Bool = false
  @State var isSelectedOn2: Bool = false
  private var lottiePlaybackMode: LottiePlaybackMode = .playing(.fromProgress(nil, toProgress: 1, loopMode: .loop))
  @State private var currentProgressStep: UInt = 0
  @State private var message: String = ""
  
  var body: some View {
    ZStack {
      ATBackgroundView()
        .edgesIgnoringSafeArea(.all)
      ScrollView {
        VStack {
          ATUnderlineInputView(leftIconImage: Image(systemName: "bolt"), placeholderMessage: "ATUnderlineInputView", message: $message, maxLength: 10)
            .padding()
          LottieView(animation: AnimationAsset.upload.animation)
            .resizable()
            .playbackMode(lottiePlaybackMode)
            .getRealtimeAnimationProgress(.constant(200))
            .frame(width: 100, height: 100)
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
          ATInputView(placeholder: "텍스트 입력하기", message: .constant(""))
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
          ATDataImage(
            data: Gen.Images.allPerson.uikitImage.pngData(),
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
            isChecked: $isSelectedOn,
            action: { isChecked in
              print("ATCheckImageButton: \(isChecked)")
            }
          )
          .frame(width: 68, height: 68)
          ATCheckImageButton(
            type: .image(.init(systemName: "bolt")),
            isChecked: $isSelectedOn2,
            action: { isChecked in
              print("ATCheckImageButton: \(isChecked)")
            }
          )
          .frame(width: 68, height: 68)
          ATPageIndicator(numberOfPages: 10, currentPage: .constant(1))
          HStack {
            Button(action: {
              if 0 < currentProgressStep {
                currentProgressStep -= 1
              }
            }, label: {
              Text("before")
            })
            ATStepProgressView(totalStep: 5, currentStep: $currentProgressStep)
            Button(action: {
              if currentProgressStep < 5 {
                currentProgressStep += 1
              }
            }, label: {
              Text("next")
            })
          }
          .frame(height: 12)
        }
      }
    }
  }
}

#Preview {
  ContentView()
}


