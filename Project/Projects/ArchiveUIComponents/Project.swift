import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

let project = Project(
  name: "ArchiveUIComponents",
  organizationName: Project.organizationName,
  packages: [],
  targets: Project.staticFrameworkTargets(
    name: "ArchiveUIComponents",
    destinations: .iOS,
    frameworkDependencies: [
      .project(
        target: "ArchiveFoundation",
        path: "../ArchiveFoundation"
      )
    ],
    testDependencies: [],
    coreDataModel: []
  ),
  schemes: [],
  additionalFiles: [],
  resourceSynthesizers: [
    .assets()
  ]
)
