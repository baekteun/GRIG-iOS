import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.staticFramework(
    name: "OnBoardingFeature",
    dependencies: [
        .Project.Features.CommonFeature
    ],
    hasDemoApp: true
)
