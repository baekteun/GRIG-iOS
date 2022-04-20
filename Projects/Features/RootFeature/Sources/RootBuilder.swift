//
//  RootBuilder.swift
//  RootFeature
//
//  Created by 최형우 on 2022/04/20.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RIBs

public protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RootComponent: Component<RootDependency> {
    let viewController: RootViewControllable
    
    init(
        dependency: RootDependency,
        viewController: RootViewControllable
    ) {
        self.viewController = viewController
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

public final class RootBuilder: Builder<RootDependency>, RootBuildable {

    public override init(dependency: RootDependency) {
        super.init(dependency: dependency)
        
    }

    public func build() -> LaunchRouting {
        let viewController = RootViewController()
        _ = RootComponent(dependency: dependency, viewController: viewController)
        let interactor = RootInteractor(presenter: viewController)
        return RootRouter(interactor: interactor, viewController: viewController)
    }
}
