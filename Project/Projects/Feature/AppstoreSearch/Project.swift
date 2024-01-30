//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Aaron Hanwe LEE on 1/29/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
  name: "AppstoreSearch",
  frameworkDependencies: [
    .swiftyJSON,
    .lottie,
    .imageLoader
  ],
  testDependencies: []
)
