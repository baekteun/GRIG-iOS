import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
    name: "InjectManager",
    dependencies: [
        .Project.Module.ThirdPartyLib,
        .Project.Module.Utility,
        .Project.Features.MainFeature,
        .Project.Service.Data,
        .Project.Service.Domain
    ]
)
