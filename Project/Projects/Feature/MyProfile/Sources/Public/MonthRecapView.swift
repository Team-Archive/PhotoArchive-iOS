//
//  MonthRecapView.swift
//  MyProfile
//
//  Created by jinyoung on 8/7/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import Domain
import UIComponents
import ArchiveFoundation

public struct MonthRecapView: View {
  
  // MARK: - public state
  
  // MARK: - private properties
  
  // MARK: - public properties
  
  
  
  // MARK: - life cycle
  
  public var body: some View {
    VStack {
      
      Spacer()
        .frame(height: 20)
      
      HStack {
        Text("이번 달 돌아보기")
          .font(.fonts(.body14))
          .foregroundStyle(Gen.Colors.white.color)
        
        Spacer()
      }
      
      Spacer()
        .frame(height: 9)
      
      ScrollView(.horizontal, showsIndicators: false) {
        let data: [String] = ["1", "2", "3", "4"]
        HStack(spacing: 8) {
          ForEach(data, id: \.self) { _ in
            VStack {
//              TextRecapView(title: "3월 중 가장 많이\n 소통한 하루", content: "3월 3일")
              ImageRecapView(
                title: "3월에 가장 많이 소통한 친구",
                image: MockImageURL.fetchData()
              )
            }
          }
        }
      }
      .frame(height: 120)
    }
    .padding(.horizontal, 20)
  }
  
  @ViewBuilder
  private func TextRecapView(title: String, content: String) -> some View {
      VStack {
        Text(title)
          .lineLimit(nil)
          .font(.fonts(.body12))
          .foregroundStyle(Gen.Colors.white.color)
          .padding(.trailing)
        
        Spacer()
        
        Text(content)
          .font(.fonts(.title24))
          .foregroundStyle(Gen.Colors.white.color)
          .padding(.trailing)
      }
      .padding(.all, 12)
      .frame(width: 120, height: 120)
      .background(Gen.Colors.purpleGray500.color)
      .overlay(content: {
        RoundedRectangle(cornerRadius: 12, style: .continuous)
          .stroke(lineWidth: 1)
          .foregroundStyle(Gen.Colors.purpleGray300.color)
      })
      .clipShape(RoundedRectangle(cornerRadius: 12))
  }
  
  @ViewBuilder
  private func ImageRecapView(title: String, image: URL?) -> some View {
    VStack(alignment: .leading) {
      Text(title)
        .lineLimit(nil)
        .font(.fonts(.body12))
        .foregroundStyle(Gen.Colors.white.color)
        .padding(.trailing)
      
      Spacer()
      
      ATUrlImage(url: image)
        .padding(.leading, 0)
        .frame(width: 44, height: 44)
        .aspectRatio(contentMode: .fill)
        .clipShape(Circle())
    }
    .padding(.all, 12)
    .frame(width: 120, height: 120)
    .background(Gen.Colors.purpleGray500.color)
    .overlay(content: {
      RoundedRectangle(cornerRadius: 12, style: .continuous)
        .stroke(lineWidth: 1)
        .foregroundStyle(Gen.Colors.purpleGray300.color)
    })
    .clipShape(RoundedRectangle(cornerRadius: 12))
  }
  
  public init() {
    
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
}
