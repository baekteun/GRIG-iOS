import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.staticFramework(
    name: "CompeteFeature",
    dependencies: [
        .Project.Features.CommonFeature
    ],
    hasDemoApp: true
)
