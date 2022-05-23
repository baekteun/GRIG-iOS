//
//  OnBoardingInteractor.swift
//  OnBoardingFeature
//
//  Created by 최형우 on 2022/05/23.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RIBs
import RxSwift

protocol OnBoardingRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol OnBoardingPresentable: Presentable {
    var listener: OnBoardingPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol OnBoardingListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class OnBoardingInteractor: PresentableInteractor<OnBoardingPresentable>, OnBoardingInteractable, OnBoardingPresentableListener {

    weak var router: OnBoardingRouting?
    weak var listener: OnBoardingListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: OnBoardingPresentable) {
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
