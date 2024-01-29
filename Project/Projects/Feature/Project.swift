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
  name: "Feature",
  organizationName: Project.organizationName,
  packages: [],
  targets: Project.staticUmbrellaFrameworkTargets(
    name: "Feature",
    destinations: .iOS,
    frameworkDependencies: Project.featureSubDirectoryNameList().map { .project(
      target: $0,
      path: "./\($0)"
    )}
  ),
  schemes: [],
  additionalFiles: [],
  resourceSynthesizers: []
)
