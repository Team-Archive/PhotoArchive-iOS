//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Aaron Hanwe LEE on 1/29/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import Foundation

let project = Project(
  name: "Data",
  organizationName: Project.organizationName,
  packages: [],
  targets: Project.staticFrameworkTargets(
    name: "Data",
    destinations: .iOS,
    frameworkDependencies: [
      .project(
        target: "ArchiveFoundation",
        path: "../ArchiveFoundation"
      ),
      .project(
        target: "Domain",
        path: "../Domain"
      ),
      .project(
        target: "APIHub",
        path: "../APIHub"
      )
    ],
    testDependencies: [
      .nimble,
      .quick
    ],
    targetScripts: [
      .pre(script: "${PROJECT_DIR}/../../Tools/swiftlint --config \"${PROJECT_DIR}/../../Tools/swiftlint.yml\"", name: "Lint")
    ],
    coreDataModel: []
  ),
  schemes: [],
  additionalFiles: [],
  resourceSynthesizers: []
)
