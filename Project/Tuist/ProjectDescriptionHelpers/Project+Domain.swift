//
//  Project+Domain.swift
//  ProjectDescriptionHelpers
//
//  Created by hanwe on 10/6/24.
//

import ProjectDescription

extension Project {
  
  public static func makeDomain(
    name: String,
    frameworkDependencies: [TargetDependency],
    testDependencies: [TargetDependency]
  ) -> Project {
    return Project(
      name: name,
      organizationName: Project.organizationName,
      packages: [],
      settings: .settings(configurations: [
        .debug(name: .debug),
        .release(name: .release)
      ]),
      targets: Project.dynamicFrameworkTargets(
        name: name,
        destinations: .iOS,
        frameworkDependencies: frameworkDependencies,
        testDependencies: testDependencies,
        targetScripts: [
          .pre(script: "${PROJECT_DIR}/../../../Tools/swiftlint --config \"${PROJECT_DIR}/../../App/Resources/swiftlint.yml\"", name: "Lint")
        ],
        coreDataModel: [],
        resources: ["Resources/**"],
        additionalSourcePaths: []
      ),
      schemes: [],
      additionalFiles: [],
      resourceSynthesizers: []
    )
  }
  
}
