import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.staticFramework(
    name: "MainFeature",
    dependencies: [
        .Project.Features.UserFeature,
        .Project.Features.SortFeature,
        .Project.Features.AboutFeature,
        .Project.Features.CompeteFeature
    ]
)
