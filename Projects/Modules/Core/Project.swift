import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
    name: "Core",
    resources: ["Resources/**"],
    dependencies: [
        .Project.Module.ThirdPartyLib
    ]
)
