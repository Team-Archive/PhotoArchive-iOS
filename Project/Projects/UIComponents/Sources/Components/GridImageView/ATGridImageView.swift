//
//  ATGridImageView.swift
//  UIComponents
//
//  Created by jinyoung on 11/10/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//
import SwiftUI

public struct ATGridImageView: View {
  
  // MARK: - public state
  public struct ATGridImageItem {
    let id: UUID
    let url: URL
    
    public init(url: URL) {
      self.id = UUID()
      self.url = url
    }
  }
  
  // MARK: - private properties
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  private let geometry: GeometryProxy
  private let tapHandler: ((ATGridImageItem) -> Void)?
  private var data: [[ATGridImageItem]] = []
  private var type: ATGridImageType?
  
  public var body: some View {
    
    if let type = type, !data.isEmpty {
      switch type {
      case .one:
        makeGridOne(with: data)
      case .two:
        makeGridTwo(with: data)
      case .three:
        makeGridThree(with: data)
      case .four:
        makeGridFour(with: data)
      case .five:
        makeGridFive(with: data)
      case .six:
        makeGridSix(with: data)
      case .seven:
        makeGridSeven(with: data)
      case .eight:
        makeGridEight(with: data)
      case .nine:
        makeGridNine(with: data)
      case .ten:
        makeGridTen(with: data)
      }
    }
  }
  
  public init(
    geometry: GeometryProxy,
    data: [ATGridImageItem],
    tapHandler: @escaping ((ATGridImageItem) -> Void)
  ) {
    self.geometry = geometry
    self.tapHandler = tapHandler
    let (type, items) = makeGridData(with: data)
    self.type = type
    self.data = items
  }
  
  // MARK: - private method
  private func tapHandler(with item: ATGridImageItem) {
    tapHandler?(item)
  }
  
  @ViewBuilder
  private func makeGridOne(with data: [[ATGridImageItem]]) -> some View {
    VStack(spacing: 2) {
      largeSqaureView(with: data[0])
    }
    .frame(width: geometry.size.width - 40)
    .clipShape(.rect(cornerRadius: 24))
  }
  
  @ViewBuilder
  private func makeGridTwo(with data: [[ATGridImageItem]]) -> some View {
    VStack(spacing: 2) {
      mediumSquareView(with: data[0])
    }
    .frame(width: geometry.size.width - 40)
    .clipShape(.rect(cornerRadius: 16))
  }
  
  @ViewBuilder
  private func makeGridThree(with data: [[ATGridImageItem]]) -> some View {
    VStack(spacing: 2) {
      smallSquareView(with: data[0])
    }
    .frame(width: geometry.size.width - 40)
    .clipShape(.rect(cornerRadius: 24))
  }
  
  @ViewBuilder
  private func makeGridFour(with data: [[ATGridImageItem]]) -> some View {
    VStack(spacing: 2) {
      mediumSquareView(with: data[0])
      mediumSquareView(with: data[1])
    }
    .frame(width: geometry.size.width - 40)
    .clipShape(.rect(cornerRadius: 16))
  }
  
  @ViewBuilder
  private func makeGridFive(with data: [[ATGridImageItem]]) -> some View {
    VStack(spacing: 2) {
      smallSquareView(with: data[0])
      smallRectangleView(with: data[1])
    }
    .frame(width: geometry.size.width - 40)
    .clipShape(.rect(cornerRadius: 16))
  }
  
  @ViewBuilder
  private func makeGridSix(with data: [[ATGridImageItem]]) -> some View {
    VStack(spacing: 2) {
      smallSquareView(with: data[0])
      smallSquareView(with: data[1])
    }
    .frame(width: geometry.size.width - 40)
    .clipShape(.rect(cornerRadius: 16))
  }
  
  @ViewBuilder
  private func makeGridSeven(with data: [[ATGridImageItem]]) -> some View {
    VStack(spacing: 2) {
      smallSquareView(with: data[0])
      smallRectangleView(with: data[1])
      smallRectangleView(with: data[2])
    }
    .frame(width: geometry.size.width - 40)
    .clipShape(.rect(cornerRadius: 16))
  }
  
  @ViewBuilder
  private func makeGridEight(with data: [[ATGridImageItem]]) -> some View {
    VStack(spacing: 2) {
      smallSquareView(with: data[0])
      smallSquareView(with: data[1])
      smallRectangleView(with: data[2])
    }
    .frame(width: geometry.size.width - 40)
    .clipShape(.rect(cornerRadius: 16))
  }
  
  @ViewBuilder
  private func makeGridNine(with data: [[ATGridImageItem]]) -> some View {
    VStack(spacing: 2) {
      smallSquareView(with: data[0])
      smallSquareView(with: data[1])
      smallSquareView(with: data[2])
    }
    .frame(width: geometry.size.width - 40)
    .clipShape(.rect(cornerRadius: 16))
    
  }
  
  @ViewBuilder
  private func makeGridTen(with data: [[ATGridImageItem]]) -> some View {
    VStack(spacing: 2) {
      smallSquareView(with: data[0])
      smallSquareView(with: data[1])
      smallRectangleView(with: data[2])
      smallRectangleView(with: data[3])
    }
    .frame(width: geometry.size.width - 40)
    .clipShape(.rect(cornerRadius: 16))
  }

  // MARK: - internal method
}

extension ATGridImageView {
  @ViewBuilder
  private func largeSqaureView(with data: [ATGridImageItem]) -> some View {
    let gridItems = [GridItem(.flexible())]
    LazyHGrid(rows: gridItems) {
      ForEach(data.indices, id: \.self) { index in
        Rectangle()
          .aspectRatio(1.0, contentMode: .fit)
          .overlay {
            ATUrlImage(url: data[index].url)
              .aspectRatio(contentMode: .fill)
          }
          .clipShape(.rect(cornerRadius: 2))
          .onTapGesture {
            tapHandler(with: data[index])
          }
        }
    }.aspectRatio(1.0, contentMode: .fill)
  }
  
  @ViewBuilder
  private func mediumSquareView(with data: [ATGridImageItem]) -> some View {
    let gridItems = [GridItem(.flexible())]
    LazyHGrid(rows: gridItems, spacing: 2) {
      ForEach(data.indices, id: \.self) { index in
        Rectangle()
          .aspectRatio(1.0, contentMode: .fit)
          .overlay {
            ATUrlImage(url: data[index].url)
              .aspectRatio(contentMode: .fill)
          }
          .clipShape(.rect(cornerRadius: 2))
          .onTapGesture {
            tapHandler(with: data[index])
          }
        }
    }.aspectRatio(2.0, contentMode: .fill)
  }
  
  @ViewBuilder
  private func smallSquareView(with data: [ATGridImageItem]) -> some View {
    let gridItems = [GridItem(.flexible())]
    LazyHGrid(rows: gridItems, spacing: 2) {
      ForEach(data.indices, id: \.self) { index in
        Rectangle()
          .aspectRatio(1.0, contentMode: .fit)
          .overlay {
            ATUrlImage(url: data[index].url)
              .aspectRatio(contentMode: .fill)
          }
          .clipShape(.rect(cornerRadius: 2))
          .onTapGesture {
            tapHandler(with: data[index])
          }
        }
    }.aspectRatio(3.0, contentMode: .fill)
  }
  
  @ViewBuilder
  private func smallRectangleView(with data: [ATGridImageItem]) -> some View {
    let gridItems = [GridItem(.flexible())]
    LazyHGrid(rows: gridItems, spacing: 2) {
      ForEach(data.indices, id: \.self) { index in
        Rectangle()
          .aspectRatio(2.0, contentMode: .fill)
          .overlay {
            ATUrlImage(url: data[index].url)
              .aspectRatio(contentMode: .fill)
          }
          .clipShape(.rect(cornerRadius: 2))
          .onTapGesture {
            tapHandler(with: data[index])
          }
        }
    }.aspectRatio(3.0, contentMode: .fill)
  }
}

// [ATGridImageItem] -> 2/3/3 등 원하는 형태로 변경하기
extension ATGridImageView {
  func makeGridData(with data: [ATGridImageItem]) -> (ATGridImageType?, [[ATGridImageItem]]) {
    // gridType을 찾고, 없으면 빈 배열 반환
    guard let gridType = ATGridImageType.gridType(for: data.count) else { return (nil, []) }

    var currentIndex = 0

    // attributes를 기반으로 데이터 슬라이스 및 배열 생성
    let items: [[ATGridImageItem]] = gridType.attributes.compactMap { attribute in
        let count = attribute.count
        let endIndex = currentIndex + count
        
        // 유효한 슬라이스만 처리
        guard endIndex <= data.count else { return nil }
        
        let slice = Array(data[currentIndex..<endIndex])
        currentIndex = endIndex
        return slice
    }
    
    return (gridType, items)
  }
}
  
