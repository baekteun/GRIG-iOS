//
//  SortBuilder.swift
//  SortFeature
//
//  Created by 최형우 on 2022/05/01.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RIBs
import Utility

public protocol SortDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SortComponent: Component<SortDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

public protocol SortBuildable: Buildable {
    func build(withListener listener: SortListener, closure: @escaping ((Criteria, Int) -> Void)) -> SortRouting
}

public final class SortBuilder: Builder<SortDependency>, SortBuildable {

    public override init(dependency: SortDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: SortListener, closure: @escaping ((Criteria, Int) -> Void)) -> SortRouting {
        let component = SortComponent(dependency: dependency)
        let viewController = SortViewController()
        let interactor = SortInteractor(presenter: viewController, closure: closure)
        interactor.listener = listener
        return SortRouter(interactor: interactor, viewController: viewController)
    }
}
