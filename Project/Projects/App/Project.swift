import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

// MARK: - Project

let project = Project.app(
  name: "App",
  destinations: .iOS,
  dependencies: [
    .firebaseAnalytics,
    .firebaseMessaging,
    .firebaseCrashlytics,
    .firebaseAppDistributionBeta,
    .firebaseDynamicLinks,
    .swiftyJSON,
    .lottie,
    .network,
    .imageLoader
  ],
  additionalTargets: [],
  additionalSourcePaths: ["../Sources/**"],
  additionalResourcePaths: []
)
