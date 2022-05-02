import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.staticFramework(
    name: "AboutFeature",
    dependencies: [
        .Project.Features.CommonFeature
    ]
)
