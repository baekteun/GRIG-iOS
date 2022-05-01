//
//  UserBuilder.swift
//  UserFeature
//
//  Created by 최형우 on 2022/04/27.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RIBs
import Domain

public protocol UserDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class UserComponent: Component<UserDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

public protocol UserBuildable: Buildable {
    func build(withListener listener: UserListener, user: GRIGAPI.GrigEntityQuery.Data.Ranking) -> UserRouting
}

public final class UserBuilder: Builder<UserDependency>, UserBuildable {

    public override init(dependency: UserDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: UserListener, user: GRIGAPI.GrigEntityQuery.Data.Ranking) -> UserRouting {
        _ = UserComponent(dependency: dependency)
        let viewController = UserViewController(user: user)
        let interactor = UserInteractor(presenter: viewController)
        interactor.listener = listener
        return UserRouter(interactor: interactor, viewController: viewController)
    }
}
