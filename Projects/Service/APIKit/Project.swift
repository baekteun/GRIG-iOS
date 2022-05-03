import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.staticFramework(
    name: "APIKit",
    sources: ["Sources/**", "Sources/**/*.graphql"],
    dependencies: [
        .Project.Module.Utility
    ]
)
