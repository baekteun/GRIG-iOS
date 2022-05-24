//
//  OnboardingBuilder.swift
//  OnboardingFeatureDemoApp
//
//  Created by 최형우 on 2022/05/23.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RIBs

public protocol OnboardingDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class OnboardingComponent: Component<OnboardingDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

public protocol OnboardingBuildable: Buildable {
    func build(withListener listener: OnboardingListener) -> OnboardingRouting
}

public final class OnboardingBuilder: Builder<OnboardingDependency>, OnboardingBuildable {

    public override init(dependency: OnboardingDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: OnboardingListener) -> OnboardingRouting {
        _ = OnboardingComponent(dependency: dependency)
        let viewController = OnboardingViewController()
        let interactor = OnboardingInteractor(presenter: viewController)
        interactor.listener = listener
        return OnboardingRouter(interactor: interactor, viewController: viewController)
    }
}
