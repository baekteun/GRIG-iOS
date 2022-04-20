import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.staticFramework(
    name: "MainFeature",
    dependencies: [
        .Project.Service.Domain,
        .Project.Module.ThirdPartyLib,
        .Project.Module.Utility,
        .Project.Module.Core
    ]
)
