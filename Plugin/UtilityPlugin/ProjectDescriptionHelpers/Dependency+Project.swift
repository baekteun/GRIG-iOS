import ProjectDescription

public extension TargetDependency {
    struct Project {
        public struct Features {}
        public struct Module {}
        public struct Service {}
    }
}

public extension TargetDependency.Project.Features {
    static let CommonFeature = TargetDependency.feature(name: "CommonFeature")
    static let MainFeature = TargetDependency.feature(name: "MainFeature")
    static let RootFeature = TargetDependency.feature(name: "RootFeature")
    static let UserFeature = TargetDependency.feature(name: "UserFeature")
    static let SortFeature = TargetDependency.feature(name: "SortFeature")
    static let AboutFeature = TargetDependency.feature(name: "AboutFeature")
    static let CompeteFeature = TargetDependency.feature(name: "CompeteFeature")
    static let OnBoardingFeature = TargetDependency.feature(name: "OnBoardingFeature")
}

public extension TargetDependency.Project.Module {
    static let Core = TargetDependency.module(name: "Core")
    static let ThirdPartyLib = TargetDependency.module(name: "ThirdPartyLib")
    static let Utility = TargetDependency.module(name: "Utility")
}

public extension TargetDependency.Project.Service {
    static let APIKit = TargetDependency.service(name: "APIKit")
    static let Data = TargetDependency.service(name: "Data")
    static let Domain = TargetDependency.service(name: "Domain")
}
