// swift-tools-version: 5.9
import PackageDescription

#if TUIST
import ProjectDescription
import ProjectDescriptionHelpers

let packageSettings = PackageSettings(
  productTypes: [
    "FirebaseAuth": .framework,
    "FirebaseAnalytics": .framework,
    "FirebaseMessaging": .framework,
    "FirebaseCrashlytics": .framework,
    "SwiftyJSON": .framework,
    "Lottie": .framework,
    "ComposableArchitecture": .framework,
    "ImageLoader-iOS": .framework,
    "Network-iOS": .framework,
    "swiftui-introspect": .framework,
    "PartialSheet": .framework
  ],
  baseSettings: .settings(configurations: [
    .debug(name: .debug),
    .release(name: .release)
  ])
)
#endif

let package = Package(
  name: "App",
  platforms: [
    .iOS(.v16)
  ],
  dependencies: [
    .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.26.0"),
    .package(url: "https://github.com/google/GoogleSignIn-iOS", from: "7.1.0"),
    .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "5.0.1"),
    .package(url: "https://github.com/airbnb/lottie-ios.git", from: "4.4.3"),
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", from: "1.7.1"),
    .package(url: "https://github.com/Team-Archive/ImageLoader-iOS.git", branch: "master"),
    .package(url: "https://github.com/Team-Archive/Network-iOS.git", branch: "master"),
    .package(url: "https://github.com/siteline/swiftui-introspect", from: "1.1.4"),
    .package(url: "https://github.com/AndreaMiotto/PartialSheet.git", from: "3.1.1")
  ],
  targets: [
    .target(
      name: "App",
      dependencies: [
        "FirebaseAuth",
        "FirebaseAnalytics",
        "FirebaseMessaging",
        "FirebaseCrashlytics",
        "SwiftyJSON",
        "Lottie",
        "ComposableArchitecture",
        "ImageLoader-iOS",
        "Network-iOS"
      ]
    )
  ]
)
