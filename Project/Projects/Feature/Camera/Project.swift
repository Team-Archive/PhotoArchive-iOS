//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Aaron Hanwe LEE on 5/19/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
  name: "Camera",
  frameworkDependencies: [
    .project(
      target: "ArchiveFoundation",
      path: "../../ArchiveFoundation"
    ),
    .project(
      target: "UIComponents",
      path: "../../UIComponents"
    ),
    .project(
      target: "Domain",
      path: "../../Domain"
    ),
    .tca,
    .swiftyJSON
  ],
  testDependencies: []
)
