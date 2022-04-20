import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.staticFramework(
    name: "Data",
    dependencies: [
        .Project.Service.Domain,
    ]
)
