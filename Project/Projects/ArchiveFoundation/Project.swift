import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

let project = Project(
  name: "ArchiveFoundation",
  organizationName: Project.organizationName,
  packages: [],
  targets: Project.staticFrameworkTargets(
    name: "ArchiveFoundation",
    destinations: .iOS,
    frameworkDependencies: [],
    testDependencies: [],
    coreDataModel: []
  ),
  schemes: [],
  additionalFiles: [],
  resourceSynthesizers: []
)
