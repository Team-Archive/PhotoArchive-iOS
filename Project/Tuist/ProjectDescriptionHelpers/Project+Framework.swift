//
//  Project+Framework.swift
//  ProjectDescriptionHelpers
//
//  Created by hanwe on 1/28/24.
//

import ProjectDescription

extension Project {
  
  public static func staticFrameworkTargets(
    name: String,
    destinations: Destinations,
    frameworkDependencies: [TargetDependency],
    testDependencies: [TargetDependency],
    targetScripts: [TargetScript] = [
      .pre(script: "${PROJECT_DIR}/../../Tools/swiftlint --config \"${PROJECT_DIR}/../../Tools/swiftlint.yml\"", name: "Lint")
    ],
    coreDataModel: [CoreDataModel],
    sampleAppAdditionalDependencies: [TargetDependency] = []
  ) -> [Target] {
    
    let sources = Target(
      name: name,
      destinations: destinations,
      product: .staticFramework,
      bundleId: "com.archive.\(name)",
      infoPlist: .default,
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      scripts: targetScripts,
      dependencies: frameworkDependencies,
      coreDataModels: coreDataModel
    )
    
    let testHostApp = Target(
      name: "\(name)TestHost",
      destinations: destinations,
      product: .app,
      bundleId: "com.archive.\(name)TestHost",
      infoPlist: .default,
      sources: ["TestHost/Sources/**"],
      resources: ["TestHost/Resources/**"],
      dependencies: [.target(name: name)]
    )
    
    let sampleApp = Target(
      name: "\(name)SampleApp",
      destinations: destinations,
      product: .app,
      bundleId: "com.archive.\(name)SampleApp",
      infoPlist: .default,
      sources: ["SampleApp/Sources/**"],
      resources: ["SampleApp/Resources/**"],
      dependencies: [.target(name: name)] + sampleAppAdditionalDependencies
    )
    
    let tests = Target(
      name: "\(name)Tests",
      destinations: destinations,
      product: .unitTests,
      bundleId: "com.archive.\(name)tests",
      infoPlist: .default,
      sources: ["Tests/**"],
      resources: [],
      dependencies: [.target(name: name), .target(name: "\(name)TestHost")] + testDependencies
    )
    
    return [sources, testHostApp, tests, sampleApp]
  }
  
  public static func staticUmbrellaFrameworkTargets(
    name: String,
    destinations: Destinations,
    frameworkDependencies: [TargetDependency]
  ) -> [Target] {
    
    let sources = Target(
      name: name,
      destinations: destinations,
      product: .staticFramework,
      bundleId: "com.archive.\(name)",
      infoPlist: .default,
      sources: [],
      resources: [],
      dependencies: frameworkDependencies
    )
    
    return [sources]
  }
  
}
