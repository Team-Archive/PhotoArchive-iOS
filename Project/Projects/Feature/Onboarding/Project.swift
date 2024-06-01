//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Aaron Hanwe LEE on 1/29/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
  name: "Onboarding",
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
    .project(
      target: "AppRoute",
      path: "../../AppRoute"
    ),
    .tca,
    .swiftyJSON,
    .imageLoader
  ],
  testDependencies: []
)
