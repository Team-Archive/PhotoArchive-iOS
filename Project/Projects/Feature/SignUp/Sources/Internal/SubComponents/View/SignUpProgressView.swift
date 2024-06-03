//
//  SignUpProgressView.swift
//  SignUp
//
//  Created by hanwe on 5/26/24.
//  Copyright © 2024 TeamArchive. All rights reserved.
//

import SwiftUI
import UIComponents
import ArchiveFoundation

struct SignUpProgressView: View {
  
  // MARK: - internal state
  
  // MARK: - private properties
  
  @Binding private var path: NavigationPath
  
  // MARK: - public properties
  
  // MARK: - life cycle
  
  init(
    path: Binding<NavigationPath>
  ) {
    self._path = path
  }
  
  var body: some View {
    ATStepProgressView(
      totalStep: UInt(SignUpStep.allCases.count),
      currentStep: Binding(
        get: { UInt(path.count + 1) },
        set: { _ in }
      )
    )
  }
  
  // MARK: - private method
  
  // MARK: - internal method
  
}
