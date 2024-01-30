//
//  Project+Feature.swift
//  ProjectDescriptionHelpers
//
//  Created by Aaron Hanwe LEE on 1/29/24.
//

import ProjectDescription

extension Project {
  
  public static func makeFeature(
    name: String,
    frameworkDependencies: [TargetDependency],
    testDependencies: [TargetDependency]
  ) -> Project {
    let willSetFrameworkDependencies: [TargetDependency] = {
      var returnValue: [TargetDependency] = frameworkDependencies
      returnValue.append(.project(
        target: "ArchiveFoundation",
        path: "../../ArchiveFoundation"
      ))
      returnValue.append(.project(
        target: "ArchiveUIComponents",
        path: "../../ArchiveUIComponents"
      ))
      returnValue.append(.project(
        target: "Domain",
        path: "../../Domain"
      ))
      returnValue.append(.project(
        target: "Data",
        path: "../../Data"
      ))
      return returnValue
    }()
    return Project(
      name: name,
      organizationName: Project.organizationName,
      packages: [],
      targets: Project.staticFrameworkTargets(
        name: name,
        destinations: .iOS,
        frameworkDependencies: willSetFrameworkDependencies,
        testDependencies: testDependencies,
        targetScripts: [
          .pre(script: "${PROJECT_DIR}/../../../Tools/swiftlint --config \"${PROJECT_DIR}/../../../Tools/swiftlint.yml\"", name: "Lint")
        ],
        coreDataModel: []
      ),
      schemes: [],
      additionalFiles: [],
      resourceSynthesizers: []
    )
  }
  
}
