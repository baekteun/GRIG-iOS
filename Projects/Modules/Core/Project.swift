import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
    name: "Core",
    dependencies: [
        .Project.Module.ThirdPartyLib,
        .Project.Module.Utility
    ]
)
