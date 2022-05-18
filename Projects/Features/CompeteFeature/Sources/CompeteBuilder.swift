//
//  CompeteBuilder.swift
//  CompeteFeatureDemoApp
//
//  Created by 최형우 on 2022/05/16.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RIBs
import ThirdPartyLib
import Domain

public protocol CompeteDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class CompeteComponent: Component<CompeteDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

public protocol CompeteBuildable: Buildable {
    func build(
        withListener listener: CompeteListener,
        myLogin: String,
        competeLogin: String
    ) -> CompeteRouting
}

public final class CompeteBuilder: Builder<CompeteDependency>, CompeteBuildable {

    override public init(dependency: CompeteDependency) {
        super.init(dependency: dependency)
    }

    public func build(
        withListener listener: CompeteListener,
        myLogin: String,
        competeLogin: String
    ) -> CompeteRouting {
        _ = CompeteComponent(dependency: dependency)
        let viewController = CompeteViewController()
        let interactor = CompeteInteractor(
            presenter: viewController,
            my: myLogin,
            compete: competeLogin
        )
        interactor.listener = listener
        return CompeteRouter(interactor: interactor, viewController: viewController)
    }
}
