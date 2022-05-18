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

protocol CompeteDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class CompeteComponent: Component<CompeteDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol CompeteBuildable: Buildable {
    func build(
        withListener listener: CompeteListener,
        myLogin: String,
        competeLogin: String
    ) -> CompeteRouting
}

final class CompeteBuilder: Builder<CompeteDependency>, CompeteBuildable {

    override init(dependency: CompeteDependency) {
        super.init(dependency: dependency)
    }

    func build(
        withListener listener: CompeteListener,
        myLogin: String,
        competeLogin: String
    ) -> CompeteRouting {
        _ = CompeteComponent(dependency: dependency)
        let viewController = CompeteViewController()
        let interactor = CompeteInteractor(
            presenter: viewController,
            fetchUesrInfoUseCase: DIContainer.resolve(FetchUserInfoUseCase.self)!,
            my: myLogin,
            compete: competeLogin
        )
        interactor.listener = listener
        return CompeteRouter(interactor: interactor, viewController: viewController)
    }
}
