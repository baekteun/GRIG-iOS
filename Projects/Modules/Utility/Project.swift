import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
    name: "Utility",
    dependencies: [
        .Project.Module.ThirdPartyLib
    ]
)
