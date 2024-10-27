import ProjectDescription

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/

import ProjectDescription
extension Project {
  
  public static func app(
    name: String,
    bundleAppName: String? = nil,
    destinations: Destinations,
    dependencies: [TargetDependency],
    testDependencies: [TargetDependency] = [],
    additionalTargets: [String],
    additionalSourcePaths: [String],
    additionalResourcePaths: [String]
  ) -> Project {
    
    let targets = makeAppTargets(
      name: name,
      bundleAppName: bundleAppName,
      destinations: destinations,
      dependencies: dependencies,
      testDependencies: testDependencies,
      additionalSourcePaths: additionalSourcePaths,
      additionalResourcePaths: additionalResourcePaths
    )
    
    return Project(
      name: name,
      organizationName: Project.organizationName,
      settings: .settings(
        configurations: [
          .debug(
            name: .debug,
            xcconfig:"./XCConfig/Debug.xcconfig"
          ),
          .release(
            name: .release,
            xcconfig:"./XCConfig/Release.xcconfig"
          ),
        ]
      ),
      targets: targets,
      resourceSynthesizers: [
      ]
    )
  }
  
  // MARK: - Private
  
  /// Helper function to create the application target and the unit test target.
  private static func makeAppTargets(
    name: String,
    bundleAppName: String? = nil,
    destinations: Destinations,
    dependencies: [TargetDependency],
    testDependencies: [TargetDependency] = [],
    additionalSourcePaths: [String],
    additionalResourcePaths: [String]
  ) -> [Target] {
    let destinations: Destinations = destinations
    
    let targetScripts: [TargetScript] = {
      var returnValue: [TargetScript] = []
      returnValue.append(.pre(script: "${PROJECT_DIR}/../../Tools/swiftlint --config \"${PROJECT_DIR}/Resources/swiftlint.yml\"", name: "Lint"))
      return returnValue
    }()
    
    let mainTarget = Target.target(
      name: name,
      destinations: destinations,
      product: .app,
      bundleId: Project.appBundleId,
      deploymentTargets: Project.deploymentTarget,
      infoPlist: .file(path: .relativeToRoot("AppInfoPlist/Info.plist")),
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      entitlements: .file(path: .relativeToRoot("Tools/App.entitlements")),
      scripts: targetScripts,
      dependencies: dependencies
    )
      
    var testDependencies = testDependencies
    testDependencies.append(.target(name: "\(name)"))
    let testTarget = Target.target(
      name: "\(name)Tests",
      destinations: destinations,
      product: .unitTests,
      bundleId: "com.archive.\(name)Tests",
      infoPlist: .default,
      sources: ["../\(name)/Tests/**"],
      dependencies: testDependencies
    )
    return [mainTarget, testTarget]
  }
}



