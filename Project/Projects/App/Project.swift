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
    ),
    .project(
      target: "AppstoreSearch",
      path: "../Feature/AppstoreSearch"
    ),
    .project(
      target: "SignUp",
      path: "../Feature/SignUp"
    ),
    .project(
      target: "Calendar",
      path: "../Feature/Calendar"
    ),
    .project(
      target: "MyProfile",
      path: "../Feature/MyProfile"
    ),
    .project(
      target: "Onboarding",
      path: "../Feature/Onboarding"
    )
  ],
  additionalTargets: [],
  additionalSourcePaths: [],
  additionalResourcePaths: [
    "../../Private/**"
  ]
)
