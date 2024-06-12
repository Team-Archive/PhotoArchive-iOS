//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by hanwe on 5/26/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeOAuth(
  name: "OAuthApple",
  frameworkDependencies: [
    .project(
      target: "ArchiveFoundation",
      path: "../../ArchiveFoundation"
    )
  ],
  testDependencies: []
)
