import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

let projectName: String = "AppRoute"
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
      .project(
        target: "Domain",
        path: "../Domain"
      )
    ],
    testDependencies: [],
    coreDataModel: []
  ),
  schemes: [],
  additionalFiles: [],
  resourceSynthesizers: []
)
