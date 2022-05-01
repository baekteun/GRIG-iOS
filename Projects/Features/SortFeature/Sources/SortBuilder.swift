//
//  SortBuilder.swift
//  SortFeature
//
//  Created by 최형우 on 2022/05/01.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RIBs

protocol SortDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SortComponent: Component<SortDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SortBuildable: Buildable {
    func build(withListener listener: SortListener) -> SortRouting
}

final class SortBuilder: Builder<SortDependency>, SortBuildable {

    override init(dependency: SortDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SortListener) -> SortRouting {
        let component = SortComponent(dependency: dependency)
        let viewController = SortViewController()
        let interactor = SortInteractor(presenter: viewController)
        interactor.listener = listener
        return SortRouter(interactor: interactor, viewController: viewController)
    }
}
