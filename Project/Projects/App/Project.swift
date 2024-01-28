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
    .project(
      target: "ArchiveFoundation",
      path: "../ArchiveFoundation"
    ),
    .project(
      target: "ArchiveUIComponents",
      path: "../ArchiveUIComponents"
    )
  ],
  additionalTargets: [],
  additionalSourcePaths: ["../Sources/**"],
  additionalResourcePaths: []
)
