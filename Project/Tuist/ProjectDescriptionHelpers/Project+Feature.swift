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
    return Project(
      name: name,
      organizationName: Project.organizationName,
      packages: [],
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
