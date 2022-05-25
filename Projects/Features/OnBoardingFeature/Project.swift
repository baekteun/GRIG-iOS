import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.staticFramework(
    name: "OnboardingFeature",
    dependencies: [
        .Project.Features.CommonFeature
    ]
)
