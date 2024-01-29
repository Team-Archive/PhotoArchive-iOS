//
//  Project+Domain.swift
//  ProjectDescriptionHelpers
//
//  Created by Aaron Hanwe LEE on 1/29/24.
//

import ProjectDescription

extension Project {
  
  public static func makeDomain(name: String, frameworkDependencies: [TargetDependency], testDependencies: [TargetDependency]) -> Project {
    let willSetFrameworkDependencies: [TargetDependency] = {
      var returnValue: [TargetDependency] = frameworkDependencies
      returnValue.append(.project(
        target: "ArchiveFoundation",
        path: "../../ArchiveFoundation"
      ))
      return returnValue
    }()
    return Project(
      name: name,
      organizationName: "TeamArchive",
      packages: [],
      targets: Project.staticFrameworkTargets(
        name: name,
        destinations: .iOS,
        frameworkDependencies: willSetFrameworkDependencies,
        testDependencies: testDependencies,
        targetScripts: [
          .pre(script: "${PROJECT_DIR}/../../../Tools/swiftlint --config \"${PROJECT_DIR}/Resources/swiftlint.yml\"", name: "Lint")
        ],
        coreDataModel: []
      ),
      schemes: [],
      additionalFiles: [],
      resourceSynthesizers: []
    )
  }
  
}
