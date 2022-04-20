import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "ThirdPartyLib",
    dependencies: [
        .SPM.RxMoya,
        .SPM.Swinject,
        .SPM.RIBs,
        .SPM.Kingfisher,
        .SPM.Reusable,
        .SPM.RxSwift,
        .SPM.RxCocoa,
        .SPM.RxRelay,
        .SPM.RxDataSources,
        .SPM.Then,
        .SPM.SnapKit
    ]
)
