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
      .pre(script: "${PROJECT_DIR}/../../Tools/swiftlint --config \"${PROJECT_DIR}/../App/Resources/swiftlint.yml\"", name: "Lint")
    ],
    coreDataModel: [CoreDataModel],
    resources: ResourceFileElements = ["Resources/**"],
    sampleAppAdditionalDependencies: [TargetDependency] = [],
    additionalSourcePaths: [String] = []
  ) -> [Target] {
    return Project.frameworkTargets(
      name: name,
      destinations: destinations,
      frameworkDependencies: frameworkDependencies,
      testDependencies: testDependencies,
      targetScripts: targetScripts,
      coreDataModel: coreDataModel,
      resources: resources,
      sampleAppAdditionalDependencies: sampleAppAdditionalDependencies,
      additionalSourcePaths: additionalSourcePaths,
      product: .staticFramework
    )
  }
  
  public static func dynamicFrameworkTargets(
    name: String,
    destinations: Destinations,
    frameworkDependencies: [TargetDependency],
    testDependencies: [TargetDependency],
    targetScripts: [TargetScript] = [
      .pre(script: "${PROJECT_DIR}/../../Tools/swiftlint --config \"${PROJECT_DIR}/../App/Resources/swiftlint.yml\"", name: "Lint")
    ],
    coreDataModel: [CoreDataModel],
    resources: ResourceFileElements = ["Resources/**"],
    sampleAppAdditionalDependencies: [TargetDependency] = [],
    additionalSourcePaths: [String] = []
  ) -> [Target] {
    return Project.frameworkTargets(
      name: name,
      destinations: destinations,
      frameworkDependencies: frameworkDependencies,
      testDependencies: testDependencies,
      targetScripts: targetScripts,
      coreDataModel: coreDataModel,
      resources: resources,
      sampleAppAdditionalDependencies: sampleAppAdditionalDependencies,
      additionalSourcePaths: additionalSourcePaths,
      product: .framework
    )
  }
  
  fileprivate static func frameworkTargets(
    name: String,
    destinations: Destinations,
    frameworkDependencies: [TargetDependency],
    testDependencies: [TargetDependency],
    targetScripts: [TargetScript] = [
      .pre(script: "${PROJECT_DIR}/../../Tools/swiftlint --config \"${PROJECT_DIR}/../App/Resources/swiftlint.yml\"", name: "Lint")
    ],
    coreDataModel: [CoreDataModel],
    resources: ResourceFileElements = ["Resources/**"],
    sampleAppAdditionalDependencies: [TargetDependency] = [],
    additionalSourcePaths: [String] = [],
    product: Product
  ) -> [Target] {
    
    let sourcesPath: SourceFilesList = {
      let globs: [SourceFileGlob] = {
        var returnValue: [SourceFileGlob] = ["Sources/**"]
        for item in additionalSourcePaths {
          returnValue.append(.glob(
            Path(item)
          ))
        }
        return returnValue
      }()
      return SourceFilesList(globs: globs)
    }()
    
    let sources = Target(
      name: name,
      destinations: destinations,
      product: .framework,
      bundleId: "com.archive.\(name)",
      deploymentTargets: .iOS("17.0"),
      infoPlist: .default,
      sources: sourcesPath,
      resources: resources,
      scripts: targetScripts,
      dependencies: frameworkDependencies,
      coreDataModels: coreDataModel
    )
    
    let testHostApp = Target(
      name: "\(name)TestHost",
      destinations: destinations,
      product: .app,
      bundleId: "com.archive.\(name)TestHost",
      deploymentTargets: .iOS("17.0"),
      infoPlist: .default,
      sources: ["TestHost/Sources/**"],
      resources: ["TestHost/Resources/**"],
      dependencies: [.target(name: name)]
    )
    
    let sampleAppInfoPlist: [String: Plist.Value] = [
      "CFBundleShortVersionString": "1.0",
      "CFBundleVersion": "1",
      "NSPhotoLibraryUsageDescription": "사진첩 권한이 필요해요",
      "UILaunchScreen": "LaunchScreen"
    ]
    
    let sampleApp = Target(
      name: "\(name)SampleApp",
      destinations: destinations,
      product: .app,
      bundleId: "com.archive.\(name)SampleApp",
      deploymentTargets: .iOS("17.0"),
      infoPlist: .extendingDefault(with: sampleAppInfoPlist),
      sources: ["SampleApp/Sources/**"],
      resources: ["SampleApp/Resources/**"],
      dependencies: [.target(name: name)] + sampleAppAdditionalDependencies
    )
    
    let tests = Target(
      name: "\(name)Tests",
      destinations: destinations,
      product: .unitTests,
      bundleId: "com.archive.\(name)tests",
      deploymentTargets: .iOS("17.0"),
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
      product: .framework,
      bundleId: "com.archive.\(name)",
      deploymentTargets: .iOS("17.0"),
      infoPlist: .default,
      sources: [],
      resources: [],
      dependencies: frameworkDependencies
    )
    
    return [sources]
  }
  
}
