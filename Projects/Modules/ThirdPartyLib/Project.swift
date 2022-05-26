import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "ThirdPartyLib",
    dependencies: [
        .SPM.Swinject,
        .SPM.RIBs,
        .SPM.Kingfisher,
        .SPM.Reusable,
        .SPM.RxSwift,
        .SPM.RxCocoa,
        .SPM.RxRelay,
        .SPM.RxDataSources,
        .SPM.Then,
        .SPM.SnapKit,
        .SPM.Apollo,
        .SPM.PanModal,
        .SPM.RxGesture,
        .SPM.ViewAnimator,
        .SPM.CDMarkdownKit,
        .SPM.NVActivityIndicatorView,
        .SPM.Loaf,
        .SPM.Charts,
        .SPM.RxKeyboard,
    ]
)
