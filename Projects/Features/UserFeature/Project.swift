import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.staticFramework(
    name: "UserFeature",
    dependencies: [
        .Project.Features.CommonFeature
    ]
)
