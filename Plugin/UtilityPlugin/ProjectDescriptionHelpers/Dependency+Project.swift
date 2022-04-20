import ProjectDescription

public extension TargetDependency {
    struct Project {
        public struct Features {}
        public struct Module {}
        public struct Service {}
    }
}

public extension TargetDependency.Project.Features {
    static let MainFeature = TargetDependency.feature(name: "MainFeature")
}

public extension TargetDependency.Project.Module {
    static let Core = TargetDependency.module(name: "Core")
    static let ThirdPartyLib = TargetDependency.module(name: "ThirdPartyLib")
    static let InjectManager = TargetDependency.module(name: "InjectManager")
    static let Utility = TargetDependency.module(name: "Utility")
}

public extension TargetDependency.Project.Service {
    static let APIKit = TargetDependency.service(name: "APIKit")
    static let Data = TargetDependency.service(name: "Data")
    static let Domain = TargetDependency.service(name: "Domain")
}
