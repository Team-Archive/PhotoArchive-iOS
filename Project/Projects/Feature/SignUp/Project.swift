//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Aaron Hanwe LEE on 5/01/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
  name: "SignUp",
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
    .swiftuiIntrospect,
    .partialSheet
  ],
  testDependencies: []
)
