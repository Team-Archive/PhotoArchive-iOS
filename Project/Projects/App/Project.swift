import ProjectDescription
import ProjectDescriptionHelpers

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
    .imageLoader,
    .tca,
    .project(
      target: "ArchiveFoundation",
      path: "../ArchiveFoundation"
    ),
    .project(
      target: "Feature",
      path: "../Feature"
    )
  ],
  additionalTargets: [],
  additionalSourcePaths: ["../Sources/**"],
  additionalResourcePaths: []
)
