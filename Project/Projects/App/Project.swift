import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

let project = Project.app(
  name: "App",
  bundleAppName: "AboutTime",
  destinations: .iOS,
  dependencies: [
    .project(
      target: "ArchiveFoundation",
      path: "../ArchiveFoundation"
    ),
    .project(
      target: "AppRoute",
      path: "../AppRoute"
    ),
    .project(
      target: "Data",
      path: "../Data"
    ),
    .project(
      target: "UIComponents",
      path: "../UIComponents"
    ),
    .firebaseAnalytics,
    .firebaseMessaging,
    .firebaseCrashlytics,
    .firebaseAppDistributionBeta,
    .firebaseDynamicLinks,
    .swiftyJSON,
    .project(
      target: "Onboarding",
      path: "../Feature/Onboarding"
    ),
    .project(
      target: "AppstoreSearch",
      path: "../Feature/AppstoreSearch"
    ),
  ],
  additionalTargets: [],
  additionalSourcePaths: ["../Sources/**"],
  additionalResourcePaths: []
)
