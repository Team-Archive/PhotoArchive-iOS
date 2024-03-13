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
      .remote(url: "https://github.com/firebase/firebase-ios-sdk.git", requirement: .exact("8.9.1")),
      .remote(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", requirement: .exact("5.0.1")),
      .remote(url: "https://github.com/airbnb/lottie-ios.git", requirement: .exact("4.0.1")),
      .remote(url: "https://github.com/Quick/Quick.git", requirement: .exact("6.1.0")),
      .remote(url: "https://github.com/Quick/Nimble.git", requirement: .exact("11.2.1")),
      .remote(url: "https://github.com/pointfreeco/swift-composable-architecture.git", requirement: .exact("1.7.1")),
      .remote(url: "https://github.com/Team-Archive/ImageLoader-iOS.git", requirement: .exact("0.1")),
      .remote(url: "https://github.com/Team-Archive/Network-iOS.git", requirement: .exact("0.4"))
    ],
    productTypes: [
      "FirebaseAuth": .framework,
      "FirebaseAnalytics": .framework,
      "FirebaseMessaging": .framework,
      "FirebaseCrashlytics": .framework,
      "FirebaseAppDistribution-Beta": .framework,
      "SwiftyJSON": .framework,
      "Lottie": .framework,
      "Quick": .framework,
      "Nimble": .framework,
      "ComposableArchitecture": .framework,
      "ImageLoader-iOS": .framework,
      "Network-iOS": .framework
    ],
    baseSettings: .settings(
      configurations: [
        .debug(name: .debug),
        .release(name: .release)
      ]
    ),
    targetSettings: [
      "Quick": ["ENABLE_TESTING_SEARCH_PATHS":"Yes"],
      "Nimble": ["ENABLE_TESTING_SEARCH_PATHS":"Yes"]
    ]
  ),
  platforms: [.iOS]
)
