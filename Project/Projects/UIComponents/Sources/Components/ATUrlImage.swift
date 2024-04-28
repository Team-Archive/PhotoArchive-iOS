//
//  ATUrlImage.swift
//  UIComponents
//
//  Created by Aaron Hanwe LEE on 4/26/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import ImageLoader_iOS

public struct ATUrlImage: View {
  
  // MARK: - public state
  
  // MARK: - private properties
  
  private let url: URL?
  private let placeholder: Image?
  private var capInsets: EdgeInsets = EdgeInsets()
  private var resizingMode: Image.ResizingMode = .stretch
  private var renderingMode: Image.TemplateRenderingMode?
  private var aspectRatio: CGFloat?
  private var contentMode: ContentMode = .fit
  private var onSuccess: (() -> Void)?
  @State private var isLoadComplete: Bool = false
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  public var body: some View {
    
    ZStack {
      if let placeholder {
        if !isLoadComplete {
          placeholder
            .resizable()
            .scaledToFill()
        }
      }
      ArchiveImage(self.url)
        .resizable(capInsets: capInsets, resizingMode: resizingMode)
        .renderingMode(renderingMode)
        .onSuccess {
          self.isLoadComplete = true
          self.onSuccess?()
        }
    }
    
  }
  
  public init(
    url: URL?,
    placeholder: Image? = nil
  ) {
    self.url = url
    self.placeholder = placeholder
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
}

extension ATUrlImage {
  public func resizable(
    capInsets: EdgeInsets = EdgeInsets(),
    resizingMode: Image.ResizingMode = .stretch
  ) -> ATUrlImage {
    var newImage = self
    newImage.capInsets = capInsets
    newImage.resizingMode = resizingMode
    return newImage
  }
  
  public func renderingMode(_ renderingMode: Image.TemplateRenderingMode?) -> ATUrlImage {
    var newImage = self
    newImage.renderingMode = renderingMode
    return newImage
  }
  
  public func aspectRatio(_ aspectRatio: CGFloat?, contentMode: ContentMode) -> ATUrlImage {
    var newImage = self
    newImage.aspectRatio = aspectRatio
    newImage.contentMode = contentMode
    return newImage
  }
  
  public func onSuccess(_ handler: @escaping () -> Void) -> ATUrlImage {
    var newImage = self
    newImage.onSuccess = handler
    return newImage
  }
}

#Preview {
  VStack {
    ATUrlImage(
      url: URL(string: "https://hips.hearstapps.com/hmg-prod/images/little-cute-maltipoo-puppy-royalty-free-image-1652926025.jpg?crop=0.444xw:1.00xh;0.129xw,0&resize=980:*")!,
      placeholder: .init(systemName: "bolt")
    )
  }
}

