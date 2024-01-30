import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

let project = Project(
  name: "APIHub",
  organizationName: Project.organizationName,
  packages: [],
  targets: Project.staticFrameworkTargets(
    name: "APIHub",
    destinations: .iOS,
    frameworkDependencies: [
      .project(
        target: "ArchiveFoundation",
        path: "../ArchiveFoundation"
      ),
      .network
    ],
    testDependencies: [],
    coreDataModel: []
  ),
  schemes: [],
  additionalFiles: [],
  resourceSynthesizers: []
)
