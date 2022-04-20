import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.staticFramework(
    name: "MainFeature",
    dependencies: [
        .Project.Features.CommonFeature
    ]
)
