import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

let project = Project.app(
  name: "App",
  bundleAppName: "AboutTime",
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
    .imageLoader,
    .project(
      target: "ArchiveFoundation",
      path: "../ArchiveFoundation"
    ),
    .project(
      target: "AppstoreSearch",
      path: "../Feature/AppstoreSearch"
    ),
    .project(
      target: "Onboarding",
      path: "../Feature/Onboarding"
    )
  ],
  additionalTargets: [],
  additionalSourcePaths: ["../Sources/**"],
  additionalResourcePaths: []
)
