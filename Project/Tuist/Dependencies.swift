//
//  Dependencies.swift
//  Config
//
//  Created by Hanwe LEE on 2024/01/21.
//

import ProjectDescription

let dependencies = Dependencies(
  carthage: CarthageDependencies([
  ]),
  swiftPackageManager: SwiftPackageManagerDependencies(
    [
      .remote(url: "https://github.com/firebase/firebase-ios-sdk.git", requirement: .exact("10.26.0")),
      .remote(url: "https://github.com/google/GoogleSignIn-iOS", requirement: .exact("7.1.0")),
      .remote(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", requirement: .exact("5.0.1")),
      .remote(url: "https://github.com/airbnb/lottie-ios.git", requirement: .exact("4.4.3")),
      .remote(url: "https://github.com/pointfreeco/swift-composable-architecture.git", requirement: .exact("1.7.1")),
      .remote(url: "https://github.com/Team-Archive/ImageLoader-iOS.git", requirement: .branch("master")),
      .remote(url: "https://github.com/Team-Archive/Network-iOS.git", requirement: .exact("0.4")),
      .remote(url: "https://github.com/siteline/swiftui-introspect", requirement: .exact("1.1.4")),
      .remote(url: "https://github.com/AndreaMiotto/PartialSheet.git", requirement: .exact("3.1.1"))
    ],
    productTypes: [
      "FirebaseAuth": .framework,
      "FirebaseAnalytics": .framework,
      "FirebaseMessaging": .framework,
      "FirebaseCrashlytics": .framework,
      "FirebaseAppDistribution-Beta": .framework,
      "GoogleSignIn": .framework,
      "SwiftyJSON": .framework,
      "Lottie": .framework,
      "ComposableArchitecture": .framework,
      "ImageLoader-iOS": .framework,
      "Network-iOS": .framework,
      "SwiftUIInstrospect": .framework,
      "PartialSheet": .framework
    ],
    baseSettings: .settings(
      configurations: [
        .debug(name: .debug),
        .release(name: .release)
      ]
    ),
    targetSettings: [:]
  ),
  platforms: [.iOS]
)
