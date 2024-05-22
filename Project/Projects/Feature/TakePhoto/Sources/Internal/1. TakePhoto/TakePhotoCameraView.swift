//
//  TakePhotoCameraView.swift
//  TakePhoto
//
//  Created by hanwe on 5/19/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import UIKit
import AVFoundation

struct TakePhotoCameraView: UIViewRepresentable {
  
  // MARK: private property
  
  // MARK: internal property
  
  var session: AVCaptureSession
  
  // MARK: lifeCycle
  
  init(session: AVCaptureSession) {
    self.session = session
  }
  
  // MARK: private function
  
  // MARK: internal function
  
  func makeUIView(context: Context) -> UIView {
    let view = UIView(frame: UIScreen.main.bounds)
    let previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
    previewLayer.videoGravity = .resizeAspectFill
    previewLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
    view.layer.addSublayer(previewLayer)
    return view
  }
  
  func updateUIView(_ uiView: UIView, context: Context) {}
  
}
