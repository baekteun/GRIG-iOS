import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.staticFramework(
    name: "SortFeature",
    dependencies: [
        .Project.Features.CommonFeature
    ]
)
