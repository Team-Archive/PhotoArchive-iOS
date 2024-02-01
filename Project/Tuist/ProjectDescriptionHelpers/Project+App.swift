import ProjectDescription

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/

extension Project {
  /// Helper function to create the Project for this ExampleApp
  public static func app(
    name: String,
    destinations: Destinations,
    dependencies: [TargetDependency],
    testDependencies: [TargetDependency] = [],
    additionalTargets: [String],
    additionalSourcePaths: [String],
    additionalResourcePaths: [String]
  ) -> Project {
    
    var targets = makeAppTargets(
      name: name,
      destinations: destinations,
      dependencies: dependencies,
      testDependencies: testDependencies,
      additionalSourcePaths: additionalSourcePaths,
      additionalResourcePaths: additionalResourcePaths
    )
    
    return Project(
      name: name,
      organizationName: Project.organizationName,
      settings: Settings.settings(
        base: [:],
        configurations: [
          .debug(
            name: "Debug",
            settings: [:],
            xcconfig: "./XCConfig/Debug.xcconfig"),
          .release(
            name: "Release",
            settings: [:],
            xcconfig: "./XCConfig/Release.xcconfig"
          )
        ],
        defaultSettings: .recommended
      ),
      targets: targets
    )
  }
  
  // MARK: - Private
  
  /// Helper function to create the application target and the unit test target.
  private static func makeAppTargets(
    name: String,
    destinations: Destinations,
    dependencies: [TargetDependency],
    testDependencies: [TargetDependency] = [],
    additionalSourcePaths: [String],
    additionalResourcePaths: [String]
  ) -> [Target] {
    let destinations: Destinations = destinations
    let infoPlist: [String: Plist.Value] = [
      "CFBundleShortVersionString": "1.0",
      "CFBundleVersion": "1"
    ]
    
    let targetScripts: [TargetScript] = {
      var returnValue: [TargetScript] = []
      
      returnValue.append(.pre(script: "${PROJECT_DIR}/../../Tools/LocalizationGen/LocalizationGen.sh", name: "LocalizationAutoGen"))
      returnValue.append(.pre(script: "${PROJECT_DIR}/../../Tools/swiftgen config run --config \"${PROJECT_DIR}/Resources/swiftgen.yml\"", name: "Gen"))
      returnValue.append(.pre(script: "${PROJECT_DIR}/../../Tools/swiftlint --config \"${PROJECT_DIR}/Resources/swiftlint.yml\"", name: "Lint"))
      return returnValue
    }()
    
//    let sources: SourceFilesList = {
//      let globs: [SourceFileGlob] = {
//        var returnValue: [SourceFileGlob] = []
//        returnValue.append(SourceFileGlob.glob("../Sources/**"))
//        for item in additionalSourcePaths {
//          returnValue.append(.glob(
//            Path(item)
//          ))
//        }
//        return returnValue
//      }()
//      return SourceFilesList(globs: globs)
//    }()
    
    let mainTarget = Target(
      name: name,
      destinations: destinations,
      product: .app,
      bundleId: "com.archive.\(name)",
      deploymentTargets: .iOS("17.0"),
      infoPlist: .extendingDefault(with: infoPlist),
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      scripts: targetScripts,
      dependencies: dependencies
    )
    
    var testDependencies = testDependencies
    testDependencies.append(.target(name: "\(name)"))
    let testTarget = Target(
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

public extension TargetDependency {
  
  static let firebaseAnalytics: TargetDependency = .external(name: "FirebaseAnalytics")
  static let firebaseMessaging: TargetDependency = .external(name: "FirebaseMessaging")
  static let firebaseCrashlytics: TargetDependency = .external(name: "FirebaseCrashlytics")
  static let firebaseAppDistributionBeta: TargetDependency = .external(name: "FirebaseAppDistribution-Beta")
  static let firebaseDynamicLinks: TargetDependency = .external(name: "FirebaseDynamicLinks")
  static let swiftyJSON: TargetDependency = .external(name: "SwiftyJSON")
  static let lottie: TargetDependency = .external(name: "Lottie")
  static let quick: TargetDependency = .external(name: "Quick")
  static let nimble: TargetDependency = .external(name: "Nimble")
  static let tca: TargetDependency = .external(name: "ComposableArchitecture")
  static let imageLoader: TargetDependency = .external(name: "ImageLoader-iOS")
  static let network: TargetDependency = .external(name: "Network-iOS")
  
}
