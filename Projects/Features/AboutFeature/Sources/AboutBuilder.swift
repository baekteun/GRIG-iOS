//
//  AboutBuilder.swift
//  AboutFeature
//
//  Created by 최형우 on 2022/05/02.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RIBs

protocol AboutDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class AboutComponent: Component<AboutDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol AboutBuildable: Buildable {
    func build(withListener listener: AboutListener) -> AboutRouting
}

final class AboutBuilder: Builder<AboutDependency>, AboutBuildable {

    override init(dependency: AboutDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: AboutListener) -> AboutRouting {
        let component = AboutComponent(dependency: dependency)
        let viewController = AboutViewController()
        let interactor = AboutInteractor(presenter: viewController)
        interactor.listener = listener
        return AboutRouter(interactor: interactor, viewController: viewController)
    }
}
