import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

let project = Project.app(
  name: "App",
  bundleAppName: "AboutTime",
  destinations: .iOS,
  dependencies: [
    .archiveFoundation,
    .appRoute,
    .data,
    .uiComponents,
    .domainCommon,
    .feature(target: "AppstoreSearch", directoryName: "AppstoreSearch"),
    .feature(target: "SignUp", directoryName: "SignUp"),
    .feature(target: "Calendar", directoryName: "Calendar"),
    .feature(target: "MyProfile", directoryName: "MyProfile"),
    .feature(target: "Onboarding", directoryName: "Onboarding")
  ],
  additionalTargets: [],
  additionalSourcePaths: [],
  additionalResourcePaths: [
    "../../Private/**"
  ]
)
