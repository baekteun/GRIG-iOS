import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.staticFramework(
    name: "Domain",
    dependencies: [
        .Project.Service.APIKit,
        .Project.Module.ThirdPartyLib,
        .SPM.Apollo,
        .Project.Module.Utility
    ]
)
