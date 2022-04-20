import ProjectDescription
import UtilityPlugin

public extension Project {
    static func staticLibrary(
        name: String,
        platform: Platform = .iOS,
        packages: [Package] = [],
        sources: SourceFilesList = .sources,
        dependencies: [TargetDependency] = [],
        hasDemoApp: Bool = false
    ) -> Project {
        return project(
            name: name,
            packages: packages,
            sources: sources,
            product: .staticLibrary,
            platform: platform,
            dependencies: dependencies,
            infoPlist: .default,
            hasDemoApp: hasDemoApp
        )
    }
    
    static func staticFramework(
        name: String,
        platform: Platform = .iOS,
        packages: [Package] = [],
        sources: SourceFilesList = .sources,
        dependencies: [TargetDependency] = [],
        hasDemoApp: Bool = false
    ) -> Project {
        return project(
            name: name,
            packages: packages,
            sources: sources,
            product: .staticFramework,
            platform: platform,
            dependencies: dependencies,
            infoPlist: .default,
            hasDemoApp: hasDemoApp
        )
    }
    
    static func framework(
        name: String,
        platform: Platform = .iOS,
        packages: [Package] = [],
        sources: SourceFilesList = .sources,
        resources: ResourceFileElements? = nil,
        dependencies: [TargetDependency] = [],
        hasDemoApp: Bool = false
    ) -> Project {
        return project(
            name: name,
            packages: packages,
            sources: sources,
            resources: resources,
            product: .framework,
            platform: platform,
            dependencies: dependencies,
            infoPlist: .default,
            hasDemoApp: hasDemoApp
        )
    }
    
}

public extension Project {
    static func project(
        name: String,
        organizationName: String = Environment.organizationName,
        packages: [Package] = [],
        sources: SourceFilesList,
        resources: ResourceFileElements? = nil,
        demoResources: ResourceFileElements? = nil,
        product: Product,
        platform: Platform,
        deploymentTarget: DeploymentTarget? = Environment.deploymentTarget,
        dependencies: [TargetDependency] = [],
        infoPlist: InfoPlist,
        hasDemoApp: Bool = false
    ) -> Project {
        let settings: Settings = .settings(
            base: Environment.baseSetting,
            configurations: [
                .debug(name: .dev, xcconfig: .relativeToXCConfig(type: .dev, name: name)),
                .debug(name: .debug),
                .release(name: .prod, xcconfig: .relativeToXCConfig(type: .prod, name: name)),
                .release(name: .release)
            ], defaultSettings: .recommended)
        let appTarget = Target(
            name: name,
            platform: platform,
            product: product,
            bundleId: "\(organizationName).\(name)",
            deploymentTarget: deploymentTarget,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            dependencies: dependencies
        )
        let demoSource: SourceFilesList = ["Demo/Sources/**"]
        let demoSources: SourceFilesList = SourceFilesList(globs: sources.globs + demoSource.globs)
        
        let demoAppTarget = Target(
            name: "\(name)DemoApp",
            platform: platform,
            product: .app,
            bundleId: "\(organizationName).\(name)DemoApp",
            deploymentTarget: Environment.deploymentTarget,
            infoPlist: .extendingDefault(with: [
                "UIMainStoryboardFile": "",
                "UILaunchStoryboardName": "LaunchScreen",
                "ENABLE_TESTS": .boolean(true),
            ]),
            sources: demoSources,
            resources: ["Demo/Resources/**"],
            dependencies: [
                .target(name: name)
            ]
        )
        
        let testTargetDependencies: [TargetDependency] = hasDemoApp
        ? [.target(name: "\(name)DemoApp")]
        : [.target(name: name)]
        
        let testTarget = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "\(organizationName).\(name)Tests",
            deploymentTarget: deploymentTarget,
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: testTargetDependencies
        )
        let schemes: [Scheme] = hasDemoApp
        ? [.makeScheme(target: .dev, name: name), .makeDemoScheme(target: .dev, name: name)]
        : [.makeScheme(target: .dev, name: name)]
        
        let targets: [Target] = hasDemoApp
        ? [appTarget, testTarget, demoAppTarget]
        : [appTarget, testTarget]
        
        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            settings: settings,
            targets: targets,
            schemes: schemes
        )
    }
}

extension Scheme {
    static func makeScheme(target: ProjectDeployTarget, name: String) -> Scheme {
        return Scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            testAction: .targets(["\(name)Tests"],
                                configuration: target.configurationName,
                                 options: .options(coverage: true, codeCoverageTargets: ["\(name)"])),
            runAction: .runAction(configuration: target.configurationName),
            archiveAction: .archiveAction(configuration: target.configurationName),
            profileAction: .profileAction(configuration: target.configurationName),
            analyzeAction: .analyzeAction(configuration: target.configurationName)
        )
    }
    static func makeDemoScheme(target: ProjectDeployTarget, name: String) -> Scheme {
        return Scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)DemoApp"]),
            testAction: .targets(["\(name)Tests"],
                                 configuration: target.configurationName,
                                 options: .options(coverage: true, codeCoverageTargets: ["\(name)DemoApp"])),
            runAction: .runAction(configuration: target.configurationName),
            archiveAction: .archiveAction(configuration: target.configurationName),
            profileAction: .profileAction(configuration: target.configurationName),
            analyzeAction: .analyzeAction(configuration: target.configurationName)
        )
    }
}
