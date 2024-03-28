import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

let projectName: String = "APIHub"
let project = Project(
  name: projectName,
  organizationName: Project.organizationName,
  packages: [],
  targets: Project.dynamicFrameworkTargets(
    name: projectName,
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
