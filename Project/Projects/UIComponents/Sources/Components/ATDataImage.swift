//
//  ATDataImage.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 5/22/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import Photos

public struct ATDataImage: View {

  // MARK: - private properties
  
  private var data: Data?
  private let placeholder: Image?
  private var capInsets: EdgeInsets = EdgeInsets()
  private var resizingMode: Image.ResizingMode = .stretch
  private var renderingMode: Image.TemplateRenderingMode?
  private var aspectRatio: CGFloat?
  private var contentMode: ContentMode = .fit
  @State private var isLoadComplete: Bool = false
  @State private var image: Image?
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  public var body: some View {
    ZStack {
      GeometryReader { geometry in
        if let placeholder, !isLoadComplete {
          placeholder
            .resizable()
            .frame(width: geometry.size.width, height: geometry.size.height)
            .scaledToFill()
        }
        if let image {
          image
            .resizable(capInsets: capInsets, resizingMode: resizingMode)
            .renderingMode(renderingMode)
            .scaledToFill()
            .frame(width: geometry.size.width, height: geometry.size.height)
            .clipped()
        }
      }
    }
    .clipped()
    .onAppear {
      loadImage()
    }
    
  }
  
  public init(
    data: Data?,
    placeholder: Image? = nil
  ) {
    self.data = data
    self.placeholder = placeholder
  }
  
  // MARK: - private method
  
  private func loadImage() {
    Task {
      if let data {
        self.image = Image(data: data)
      }
    }
  }
  
  // MARK: - internal method
  
}

extension ATDataImage {
  public func resizable(
    capInsets: EdgeInsets = EdgeInsets(),
    resizingMode: Image.ResizingMode = .stretch
  ) -> ATDataImage {
    var newImage = self
    newImage.capInsets = capInsets
    newImage.resizingMode = resizingMode
    return newImage
  }
  
  public func renderingMode(_ renderingMode: Image.TemplateRenderingMode?) -> ATDataImage {
    var newImage = self
    newImage.renderingMode = renderingMode
    return newImage
  }
  
  public func aspectRatio(_ aspectRatio: CGFloat?, contentMode: ContentMode) -> ATDataImage {
    var newImage = self
    newImage.aspectRatio = aspectRatio
    newImage.contentMode = contentMode
    return newImage
  }
}

#Preview {
  VStack {
    ATPHAssetImage(asset: .init())
  }
}
