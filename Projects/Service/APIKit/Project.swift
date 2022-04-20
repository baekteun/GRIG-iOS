import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.staticFramework(
    name: "APIKit",
    dependencies: [
        .Project.Module.ThirdPartyLib
    ]
)
