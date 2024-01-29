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
  name: "Domain",
  organizationName: "TeamArchive",
  packages: [],
  targets: Project.staticUmbrellaFrameworkTargets(
    name: "Domain",
    destinations: .iOS,
    frameworkDependencies: Project.domainSubDirectoryNameList().map { .project(
      target: $0,
      path: "./\($0)"
    )}
  ),
  schemes: [],
  additionalFiles: [],
  resourceSynthesizers: []
)
