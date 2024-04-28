//
//  ATCheckImageButton.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 4/26/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI

public struct ATCheckImageButton: View {
  
  public enum ButtonType {
    case image(_ image: Image)
    case url(url: URL?, placeholder: Image?)
  }
  
  // MARK: - public state
  
  @State public var isChecked: Bool
  let type: ButtonType
  
  // MARK: - private properties
  
  private var borderColor: Color {
    if self.isChecked {
      return UIComponentsAsset.Colors.purple.swiftUIColor
    } else {
      return .clear
    }
  }
  
  
  @ViewBuilder
  private var CheckView: some View {
    ZStack(alignment: .bottomTrailing) {
      
      Circle()
        .fill(.clear)
        .overlay(
          Circle()
            .stroke(self.borderColor, lineWidth: 2)
        )
      
      if isChecked {
        ZStack {
          Circle()
            .fill(UIComponentsAsset.Colors.imageSelectBorder.swiftUIColor)
            .frame(width: 26, height: 26)
          Circle()
            .fill(self.borderColor)
            .frame(width: 24, height: 24)
          UIComponentsAsset.Images.check.swiftUIImage
            .resizable()
            .renderingMode(.template)
            .foregroundStyle(UIComponentsAsset.Colors.white.swiftUIColor)
            .frame(width: 12, height: 12)
        }
      } else {
        EmptyView()
      }
      
    }
  }
  
  // MARK: - public properties
  
  public var action: (_ isChecked: Bool) -> Void
  
  // MARK: - life cycle
  
  public var body: some View {
    
    Button(action: {
      self.isChecked = !self.isChecked
      self.action(self.isChecked)
    }, label: {
      ZStack {
        ZStack {
          switch self.type {
          case .image(let image):
            ZStack {
              Circle()
                .fill(.clear)
              image
                .renderingMode(.template)
                .tint(UIComponentsAsset.Colors.white.swiftUIColor)
                .padding(14)
            }
          case .url(let url, let placeholder):
            ATUrlImage(url: url, placeholder: placeholder)
              .scaledToFill()
          }
        }
        .background(UIComponentsAsset.Colors.purpleGray200.swiftUIColor)
        .clipShape(.circle)
        .padding(4)
        
        CheckView
        
      }
    })
    
  }
  
  public init(
    type: ButtonType,
    isChecked: Bool,
    action: @escaping (_ isChecked: Bool) -> Void
  ) {
    self.type = type
    self.isChecked = isChecked
    self.action = action
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
}

#Preview {
  VStack {
    ATCheckImageButton(
      type: .url(
        url: URL(string: "https://hips.hearstapps.com/hmg-prod/images/little-cute-maltipoo-puppy-royalty-free-image-1652926025.jpg?crop=0.444xw:1.00xh;0.129xw,0&resize=980:*")!,
        placeholder: .init(systemName: "bolt")
      ),
      isChecked: false,
      action: { isChecked in
        print("hola: \(isChecked)")
      }
    )
    .frame(width: 100, height: 100)
  }
}
