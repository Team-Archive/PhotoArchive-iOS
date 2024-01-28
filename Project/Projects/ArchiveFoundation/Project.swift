import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

let project = Project(
  name: "ArchiveFoundation",
  organizationName: "TeamArchive",
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
