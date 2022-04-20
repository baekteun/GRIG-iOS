import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.staticFramework(
    name: "CommonFeature",
    dependencies: [
        .Project.Service.Domain,
        .Project.Module.ThirdPartyLib,
        .Project.Module.Utility,
        .Project.Module.Core
    ]
)
