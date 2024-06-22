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
    .project(
      target: "Domain",
      path: "../Domain"
    )
  ],
  additionalTargets: [],
  additionalSourcePaths: [],
  additionalResourcePaths: [
    "../../Private/**"
  ]
)
