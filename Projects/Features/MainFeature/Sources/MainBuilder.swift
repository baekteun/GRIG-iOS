//
//  MainBuilder.swift
//  MainFeatureTests
//
//  Created by 최형우 on 2022/04/21.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RIBs
import UserFeature
import SortFeature
import AboutFeature
import CompeteFeature

public protocol MainDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

public final class MainComponent: Component<MainDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

extension MainComponent: UserDependency, SortDependency, AboutDependency, CompeteDependency {}

// MARK: - Builder

public protocol MainBuildable: Buildable {
    func build(withListener listener: MainListener) -> MainRouting
}

public final class MainBuilder: Builder<MainDependency>, MainBuildable {

    public override init(dependency: MainDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: MainListener) -> MainRouting {
        let component = MainComponent(dependency: dependency)
        let viewController = MainViewController()
        let interactor = MainInteractor(presenter: viewController)
        interactor.listener = listener
        let userBuilder = UserBuilder(dependency: component)
        let sortBuilder = SortBuilder(dependency: component)
        let aboutBuilder = AboutBuilder(dependency: component)
        let competeBuilder = CompeteBuilder(dependency: component)
        return MainRouter(
            interactor: interactor,
            viewController: viewController,
            userBuilder: userBuilder,
            sortBuilder: sortBuilder,
            aboutBuilder: aboutBuilder,
            competeBuilder: competeBuilder
        )
    }
}
