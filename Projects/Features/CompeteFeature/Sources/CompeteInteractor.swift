//
//  CompeteInteractor.swift
//  CompeteFeatureDemoApp
//
//  Created by 최형우 on 2022/05/16.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RIBs
import RxSwift

protocol CompeteRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol CompetePresentable: Presentable {
    var listener: CompetePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol CompeteListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class CompeteInteractor: PresentableInteractor<CompetePresentable>, CompeteInteractable, CompetePresentableListener {

    weak var router: CompeteRouting?
    weak var listener: CompeteListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: CompetePresentable) {
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
