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
import Foundation

public protocol OnboardingRouting: ViewableRouting {
}

protocol OnboardingPresentable: Presentable {
    var listener: OnboardingPresentableListener? { get set }
    
    var nextpageTrigger: Observable<Int> { get }
    var xButtonTrigger: Observable<Void> { get }
    var nextButtonDidTap: Observable<Void> { get }
}

public protocol OnboardingListener: AnyObject {
    func detachOnboardingAndAttachMain()
}

final class OnboardingInteractor: PresentableInteractor<OnboardingPresentable>, OnboardingInteractable, OnboardingPresentableListener {
    
    private var page = 0
    
    private let onboardRelay = BehaviorRelay<Onboard>(value: .rank)
    private let indexPathRelay = BehaviorRelay<IndexPath>(value: .init(item: 0, section: 0))

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
    }
    
}

extension OnboardingInteractor {
    var displayedOnboard: BehaviorRelay<Onboard> { onboardRelay }
    var nextButtonPaging: BehaviorRelay<IndexPath> { indexPathRelay }
}

private extension OnboardingInteractor {
    func bindPresenter() {
        presenter.nextpageTrigger
            .distinctUntilChanged()
            .bind(with: self) { owner, page in
                owner.page = page
            }
            .disposeOnDeactivate(interactor: self)

        presenter.nextpageTrigger
            .distinctUntilChanged()
            .map { Onboard.allCases[$0] }
            .bind(to: onboardRelay)
            .disposeOnDeactivate(interactor: self)

        presenter.xButtonTrigger
            .bind(with: self) { owner, _ in
                owner.saveOnboardingUseCase.execute(onboarding: true)
                owner.listener?.detachOnboardingAndAttachMain()
            }
            .disposeOnDeactivate(interactor: self)

        presenter.nextButtonDidTap
            .bind(with: self) { owner, _ in
                if owner.onboardRelay.value == .sort {
                    owner.saveOnboardingUseCase.execute(onboarding: true)
                    owner.listener?.detachOnboardingAndAttachMain()
                } else {
                    owner.indexPathRelay.accept(.init(item: owner.page+1, section: 0))
                }
            }
            .disposeOnDeactivate(interactor: self)
    }
}
