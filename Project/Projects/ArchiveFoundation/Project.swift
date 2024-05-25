import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

let projectName: String = "ArchiveFoundation"
let project = Project(
  name: projectName,
  organizationName: Project.organizationName,
  packages: [],
  targets: Project.dynamicFrameworkTargets(
    name: projectName,
    destinations: .iOS,
    frameworkDependencies: [],
    testDependencies: [],
    coreDataModel: []
  ),
  schemes: [],
  additionalFiles: [],
  resourceSynthesizers: [
    .json()
  ]
)
