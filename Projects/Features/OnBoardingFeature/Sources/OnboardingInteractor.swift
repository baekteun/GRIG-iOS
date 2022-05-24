//
//  OnboardingInteractor.swift
//  OnboardingFeatureDemoApp
//
//  Created by 최형우 on 2022/05/23.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RIBs
import RxSwift
import Utility
import RxRelay
import Domain
import ThirdPartyLib

public protocol OnboardingRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol OnboardingPresentable: Presentable {
    var listener: OnboardingPresentableListener? { get set }
    
    var nextpageTrigger: Observable<Int> { get }
}

public protocol OnboardingListener: AnyObject {
    
}

final class OnboardingInteractor: PresentableInteractor<OnboardingPresentable>, OnboardingInteractable, OnboardingPresentableListener {
    
    private var page = 0
    
    private let onboardRelay = BehaviorRelay<Onboard>(value: .rank)

    weak var router: OnboardingRouting?
    weak var listener: OnboardingListener?
    
    private let saveOnboardingUseCase: SaveOnboardingUseCase

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(
        presenter: OnboardingPresentable,
        saveOnboardingUseCase: SaveOnboardingUseCase = DIContainer.resolve(SaveOnboardingUseCase.self)!
    ) {
        self.saveOnboardingUseCase = saveOnboardingUseCase
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        bindPresenter()
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}

extension OnboardingInteractor {
    var displayedOnboard: BehaviorRelay<Onboard> { onboardRelay }
}

private extension OnboardingInteractor {
    func bindPresenter() {
        presenter.nextpageTrigger
            .distinctUntilChanged()
            .map { Onboard.allCases[$0] }
            .bind(to: onboardRelay)
            .disposeOnDeactivate(interactor: self)
    }
}
