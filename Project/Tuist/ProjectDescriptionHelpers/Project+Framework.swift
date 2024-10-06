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
    infoPlist: InfoPlist = .default,
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
      infoPlist: infoPlist,
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
    infoPlist: InfoPlist = .default ,
    frameworkDependencies: [TargetDependency],
    testDependencies: [TargetDependency],
    targetScripts: [TargetScript] = [
      .pre(script: "${PROJECT_DIR}/../../Tools/swiftlint --config \"${PROJECT_DIR}/../App/Resources/swiftlint.yml\"", name: "Lint")
    ],
    coreDataModel: [CoreDataModel],
    resources: ResourceFileElements = ["Resources/**"],
    sampleAppAdditionalDependencies: [TargetDependency] = [],
    sampleAppResources: ResourceFileElements = ["SampleApp/Resources/**"],
    additionalSourcePaths: [String] = []
  ) -> [Target] {
    return Project.frameworkTargets(
      name: name,
      destinations: destinations,
      infoPlist: infoPlist,
      frameworkDependencies: frameworkDependencies,
      testDependencies: testDependencies,
      targetScripts: targetScripts,
      coreDataModel: coreDataModel,
      resources: resources,
      sampleAppAdditionalDependencies: sampleAppAdditionalDependencies,
      sampleAppResources: sampleAppResources,
      additionalSourcePaths: additionalSourcePaths,
      product: .framework
    )
  }
  
  fileprivate static func frameworkTargets(
    name: String,
    destinations: Destinations,
    infoPlist: InfoPlist = .default,
    frameworkDependencies: [TargetDependency],
    testDependencies: [TargetDependency],
    targetScripts: [TargetScript] = [],
    coreDataModel: [CoreDataModel],
    resources: ResourceFileElements = ["Resources/**"],
    sampleAppAdditionalDependencies: [TargetDependency] = [],
    sampleAppResources: ResourceFileElements = ["SampleApp/Resources/**"],
    additionalSourcePaths: [String] = [],
    product: Product
  ) -> [Target] {
    
    let sourcesPath: SourceFilesList = {
      var globs: [SourceFileGlob] = ["Sources/**"]
      for item in additionalSourcePaths {
        globs.append(.glob(Path(stringLiteral: item)))
      }
      return SourceFilesList.sourceFilesList(globs: globs)
    }()
    
    let sources = Target.target(
      name: name,
      destinations: destinations,
      product: .framework,
      bundleId: "com.archive.\(name)",
      deploymentTargets: Project.deploymentTarget,
      infoPlist: infoPlist,
      sources: sourcesPath,
      resources: resources,
      scripts: targetScripts,
      dependencies: frameworkDependencies,
      settings: .settings(configurations: [
        .debug(name: .debug),
        .release(name: .release)
      ]),
      coreDataModels: coreDataModel
    )
    
    let testHostApp = Target.target(
      name: "\(name)TestHost",
      destinations: destinations,
      product: .app,
      bundleId: "com.archive.\(name)TestHost",
      deploymentTargets: Project.deploymentTarget,
      infoPlist: .default,
      sources: ["TestHost/Sources/**"],
      resources: ["TestHost/Resources/**"],
      dependencies: [.target(name: name)]
    )
    
    let sampleAppInfoPlist: [String: Plist.Value] = [
      "CFBundleShortVersionString": "1.0",
      "CFBundleVersion": "1",
      "NSPhotoLibraryUsageDescription": "사진첩 권한이 필요해요",
      "NSCameraUsageDescription": "카메라 권한이 필요해요",
      "UILaunchScreen": "LaunchScreen"
    ]
    
    let sampleApp = Target.target(
      name: "\(name)SampleApp",
      destinations: destinations,
      product: .app,
      bundleId: Project.bundleId(name),
      deploymentTargets: Project.deploymentTarget,
      infoPlist: .file(path: .relativeToRoot("FrameworkCommonPlist/CommonFrameworkSampleApp-Info.plist")),
      sources: ["SampleApp/Sources/**"],
      resources: sampleAppResources,
      dependencies: [.target(name: name)] + sampleAppAdditionalDependencies
    )
    
    let tests = Target.target(
      name: "\(name)Tests",
      destinations: destinations,
      product: .unitTests,
      bundleId: "com.archive.\(name)tests",
      deploymentTargets: Project.deploymentTarget,
      infoPlist: .default,
      sources: ["Tests/**"],
      resources: [],
      dependencies: [.target(name: name), .target(name: "\(name)TestHost")] + testDependencies
    )
    
    return [sources, testHostApp, tests, sampleApp]
  }
  
}

