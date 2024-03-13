import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

let project = Project(
  name: "ArchiveUIComponents",
  organizationName: Project.organizationName,
  packages: [],
  targets: Project.dynamicFrameworkTargets(
    name: "ArchiveUIComponents",
    destinations: .iOS,
    frameworkDependencies: [
      .project(
        target: "ArchiveFoundation",
        path: "../ArchiveFoundation"
      )
    ],
    testDependencies: [],
    coreDataModel: [],
    resources: ["${PROJECT_DIR}/../../App/Resources/**"],
    additionalSourcePaths: [
      "${PROJECT_DIR}/../../App/Sources/1.Extension/DesignFont.swift"
    ]
  ),
  schemes: [],
  additionalFiles: [],
  resourceSynthesizers: [
    .assets()
  ]
)
