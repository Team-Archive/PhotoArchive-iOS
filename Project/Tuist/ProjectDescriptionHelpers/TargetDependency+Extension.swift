//
//  TargetDependency+Extension.swift
//  ProjectDescriptionHelpers
//
//  Created by hanwe on 10/6/24.
//

import ProjectDescription

public extension TargetDependency {
  
  static let firebaseAnalytics: TargetDependency = .external(name: "FirebaseAnalytics")
  static let firebaseMessaging: TargetDependency = .external(name: "FirebaseMessaging")
  static let firebaseCrashlytics: TargetDependency = .external(name: "FirebaseCrashlytics")
  static let firebaseAppDistributionBeta: TargetDependency = .external(name: "FirebaseAppDistribution-Beta")
  static let firebaseDynamicLinks: TargetDependency = .external(name: "FirebaseDynamicLinks")
  static let googleSignIn: TargetDependency = .external(name: "GoogleSignIn")
  static let swiftyJSON: TargetDependency = .external(name: "SwiftyJSON")
  static let lottie: TargetDependency = .external(name: "Lottie")
  static let tca: TargetDependency = .external(name: "ComposableArchitecture")
  static let imageLoader: TargetDependency = .external(name: "ImageLoader-iOS")
  static let network: TargetDependency = .external(name: "Network-iOS")
  static let swiftuiIntrospect: TargetDependency = .external(name: "SwiftUIIntrospect")
  static let partialSheet: TargetDependency = .external(name: "PartialSheet")
  
  static let archiveFoundation: TargetDependency = .project(target: "ArchiveFoundation", path: .rootProjectPath("ArchiveFoundation"))
  static let uiComponents: TargetDependency = .project(target: "UIComponents", path: .rootProjectPath("UIComponents"))
  static let data: TargetDependency = .project(target: "Data", path: .rootProjectPath("Data"))
  static let featureInterface: TargetDependency = .project(target: "FeatureInterface", path: .rootProjectPath("FeatureInterface"))
  static let domain: TargetDependency = .project(target: "Domain", path: .rootProjectPath("Domain"))
  
  static func feature(target: String, directoryName: String) -> TargetDependency {
    return .project(target: target, path: .featureProjectPath(directoryName))
  }
  
  static func domain(target: String, directoryName: String) -> TargetDependency {
    return .project(target: target, path: .domainProjectPath(directoryName))
  }
  
}
