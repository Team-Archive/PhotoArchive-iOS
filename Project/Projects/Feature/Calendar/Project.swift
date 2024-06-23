import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
  name: "Calendar",
  frameworkDependencies: [
    .project(
      target: "ArchiveFoundation",
      path: "../../ArchiveFoundation"
    ),
    .project(
      target: "UIComponents",
      path: "../../UIComponents"
    ),
    .project(
      target: "Domain",
      path: "../../Domain"
    ),
    .project(
      target: "AppRoute",
      path: "../../AppRoute"
    ),
    .tca,
    .swiftyJSON
  ],
  testDependencies: []
)
