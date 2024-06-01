//
//  ATPHAssetImage.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 5/13/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import Photos

public struct ATPHAssetImage: View {

  // MARK: - private properties
  
  private var asset: PHAsset?
  private let placeholder: Image?
  private var capInsets: EdgeInsets = EdgeInsets()
  private var resizingMode: Image.ResizingMode = .stretch
  private var renderingMode: Image.TemplateRenderingMode?
  private var aspectRatio: CGFloat?
  private var contentMode: ContentMode = .fit
  @State private var isLoadComplete: Bool = false
  @State private var image: Image?
  @State private var previousAssetIdentifier: String?
  
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
      loadImageIfNeeded()
    }
    
  }
  
  public init(
    asset: PHAsset?,
    placeholder: Image? = nil
  ) {
    self.asset = asset
    self.placeholder = placeholder
  }
  
  // MARK: - private method
  
  private func loadImageIfNeeded() {
    guard let asset = asset else { return }
    if previousAssetIdentifier != asset.localIdentifier {
      loadImage()
      previousAssetIdentifier = asset.localIdentifier
    }
  }
  
  private func loadImage() {
    Task {
      if let asset {
        let result = await asset.toImage(.thumbnail)
        switch result {
        case .success(let image):
          DispatchQueue.main.async {
            self.isLoadComplete = true
            self.image = image
          }
        case .failure(let err):
          print("image load err: \(err)")
        }
      }
    }
  }
  
  // MARK: - internal method
  
}

extension ATPHAssetImage {
  public func resizable(
    capInsets: EdgeInsets = EdgeInsets(),
    resizingMode: Image.ResizingMode = .stretch
  ) -> ATPHAssetImage {
    var newImage = self
    newImage.capInsets = capInsets
    newImage.resizingMode = resizingMode
    return newImage
  }
  
  public func renderingMode(_ renderingMode: Image.TemplateRenderingMode?) -> ATPHAssetImage {
    var newImage = self
    newImage.renderingMode = renderingMode
    return newImage
  }
  
  public func aspectRatio(_ aspectRatio: CGFloat?, contentMode: ContentMode) -> ATPHAssetImage {
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
