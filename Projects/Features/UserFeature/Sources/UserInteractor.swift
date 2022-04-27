//
//  UserInteractor.swift
//  UserFeature
//
//  Created by 최형우 on 2022/04/27.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RIBs
import RxSwift

public protocol UserRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol UserPresentable: Presentable {
    var listener: UserPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

public protocol UserListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class UserInteractor: PresentableInteractor<UserPresentable>, UserInteractable, UserPresentableListener {

    weak var router: UserRouting?
    weak var listener: UserListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: UserPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
