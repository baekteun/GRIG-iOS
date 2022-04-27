//
//  MainBuilder.swift
//  MainFeatureTests
//
//  Created by 최형우 on 2022/04/21.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RIBs
import UserFeature

public protocol MainDependency: Dependency, UserDependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

public final class MainComponent: Component<MainDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

public protocol MainBuildable: Buildable {
    func build(withListener listener: MainListener) -> MainRouting
}

public final class MainBuilder: Builder<MainDependency>, MainBuildable {

    public override init(dependency: MainDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: MainListener) -> MainRouting {
        _ = MainComponent(dependency: dependency)
        let viewController = MainViewController()
        let interactor = MainInteractor(presenter: viewController)
        interactor.listener = listener
        let userBuilder = UserBuilder(dependency: dependency)
        return MainRouter(interactor: interactor, viewController: viewController, userBuilder: userBuilder)
    }
}
