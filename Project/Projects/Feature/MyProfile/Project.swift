import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
  name: "MyProfile",
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
    .project(
      target: "Calendar",
      path: "../Calendar"
    ),
    .tca,
    .swiftyJSON
  ],
  testDependencies: []
)
