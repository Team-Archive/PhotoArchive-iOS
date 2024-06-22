//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Aaron Hanwe LEE on 1/29/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import Foundation

let projectName: String = "Data"
let project = Project(
  name: projectName,
  organizationName: Project.organizationName,
  packages: [],
  targets: Project.dynamicFrameworkTargets(
    name: projectName,
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
      .network,
      .swiftyJSON
    ],
    testDependencies: [
    ],
    targetScripts: [
      .pre(script: "${PROJECT_DIR}/../../Tools/swiftlint --config \"${PROJECT_DIR}/../App/Resources/swiftlint.yml\"", name: "Lint")
    ],
    coreDataModel: []
  ),
  schemes: [],
  additionalFiles: [],
  resourceSynthesizers: []
)
