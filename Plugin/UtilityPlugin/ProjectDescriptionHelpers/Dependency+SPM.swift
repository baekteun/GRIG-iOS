
import ProjectDescription

public extension TargetDependency {
    struct SPM {}
}

public extension TargetDependency.SPM {
    static let RxMoya = TargetDependency.external(name: "RxMoya")
    static let RIBs = TargetDependency.external(name: "RIBs")
    static let Swinject = TargetDependency.external(name: "Swinject")
    static let RxDataSources = TargetDependency.external(name: "RxDataSources")
    static let SnapKit = TargetDependency.external(name: "SnapKit")
    static let Then = TargetDependency.external(name: "Then")
    static let Reusable = TargetDependency.external(name: "Reusable")
    static let RxSwift = TargetDependency.external(name: "RxSwift")
    static let RxCocoa = TargetDependency.external(name: "RxCocoa")
    static let RxRelay = TargetDependency.external(name: "RxRelay")
    static let Kingfisher = TargetDependency.external(name: "Kingfisher")
    static let Quick = TargetDependency.external(name: "Quick")
    static let Nimble = TargetDependency.external(name: "Nimble")
}
