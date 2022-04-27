import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
    name: "ModuleKeep",
    dependencies: [
        .Project.Service.Data
    ]
)
