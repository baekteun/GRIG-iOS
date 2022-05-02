//
//  AboutBuilder.swift
//  AboutFeature
//
//  Created by 최형우 on 2022/05/02.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RIBs

public protocol AboutDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class AboutComponent: Component<AboutDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

public protocol AboutBuildable: Buildable {
    func build(withListener listener: AboutListener) -> AboutRouting
}

public final class AboutBuilder: Builder<AboutDependency>, AboutBuildable {

    public override init(dependency: AboutDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: AboutListener) -> AboutRouting {
        let component = AboutComponent(dependency: dependency)
        let viewController = AboutViewController()
        let interactor = AboutInteractor(presenter: viewController)
        interactor.listener = listener
        return AboutRouter(interactor: interactor, viewController: viewController)
    }
}
