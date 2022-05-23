//
//  OnBoardingBuilder.swift
//  OnBoardingFeature
//
//  Created by 최형우 on 2022/05/23.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RIBs

protocol OnBoardingDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class OnBoardingComponent: Component<OnBoardingDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol OnBoardingBuildable: Buildable {
    func build(withListener listener: OnBoardingListener) -> OnBoardingRouting
}

final class OnBoardingBuilder: Builder<OnBoardingDependency>, OnBoardingBuildable {

    override init(dependency: OnBoardingDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: OnBoardingListener) -> OnBoardingRouting {
        let component = OnBoardingComponent(dependency: dependency)
        let viewController = OnBoardingViewController()
        let interactor = OnBoardingInteractor(presenter: viewController)
        interactor.listener = listener
        return OnBoardingRouter(interactor: interactor, viewController: viewController)
    }
}
