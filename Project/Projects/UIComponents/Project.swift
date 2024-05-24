import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

let project = Project(
  name: "UIComponents",
  organizationName: Project.organizationName,
  packages: [],
  targets: Project.dynamicFrameworkTargets(
    name: "UIComponents",
    destinations: .iOS,
    frameworkDependencies: [
      .project(
        target: "ArchiveFoundation",
        path: "../ArchiveFoundation"
      ),
      .imageLoader,
      .lottie
    ],
    testDependencies: [],
    targetScripts: [
      .pre(script: "${PROJECT_DIR}/../../Tools/LocalizationGen/LocalizationGen.sh", name: "LocalizationAutoGen"),
      .pre(script: "${PROJECT_DIR}/../../Tools/swiftgen config run --config \"${PROJECT_DIR}/Resources/uiComponentsSwiftgen.yml\"", name: "Gen"),
      .pre(script: "${PROJECT_DIR}/../../Tools/swiftlint --config \"${PROJECT_DIR}/../App/Resources/swiftlint.yml\"", name: "Lint")
    ],
    coreDataModel: []
  ),
  schemes: [],
  additionalFiles: [],
  resourceSynthesizers: [
    .assets(),
    .custom(
      name: "Lottie",
      parser: .json,
      extensions: ["lottie"]
    )
  ]
)
