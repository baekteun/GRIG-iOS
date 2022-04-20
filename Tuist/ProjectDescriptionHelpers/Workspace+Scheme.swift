import ProjectDescription
import UtilityPlugin

public extension Scheme {
    struct Workspace {}
}

public extension Scheme.Workspace {
    static func makeAppScheme(target: ProjectDeployTarget) -> Scheme {
        return Scheme(name: "Workspace-App-\(target.rawValue)",
                      shared: true,
                      buildAction: .buildAction(targets: [.project(path: .app, target: Environment.targetName)], preActions: []),
                      testAction: .targets([TestableTarget(target: .project(path: .app, target: "AppTests"))],
                                           configuration: target.configurationName,
                                           options: TestActionOptions.options(coverage: true, codeCoverageTargets: [.project(path: .app, target: Environment.targetName)])),
                      runAction: .runAction(configuration: target.configurationName),
                      archiveAction: .archiveAction(configuration: target.configurationName),
                      profileAction: .profileAction(configuration: target.configurationName),
                      analyzeAction: .analyzeAction(configuration: target.configurationName))
    }
}
