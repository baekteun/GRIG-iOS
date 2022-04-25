import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
    name: "InjectManager",
    dependencies: [
        .Project.Module.Utility,
        .Project.Features.RootFeature,
        .Project.Service.Data
    ]
)
