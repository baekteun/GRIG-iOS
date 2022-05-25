//
//  RootInteractor.swift
//  RootFeature
//
//  Created by 최형우 on 2022/04/20.
//  Copyright © 2022 baegteun. All rights reserved.
//
import RIBs
import RxSwift
import Domain
import ThirdPartyLib

public protocol RootRouting: ViewableRouting {
    func attachMain()
    func attachOnboarding()
    func detachMain()
    func detachOnboarding()
    func detachOnboardingAndAttachMain()
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
}

public protocol RootListener: AnyObject {
}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener {

    weak var router: RootRouting?
    weak var listener: RootListener?
    
    private let shouldOnboardingUseCase: ShouldOnboardingUseCase

    init(
        presenter: RootPresentable,
        shouldOnboardingUseCase: ShouldOnboardingUseCase = DIContainer.resolve(ShouldOnboardingUseCase.self)!
    ) {
        self.shouldOnboardingUseCase = shouldOnboardingUseCase
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        if shouldOnboardingUseCase.execute() {
            router?.attachMain()
        } else {
            router?.attachOnboarding()
        }
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func detachOnboardingAndAttachMain() {
        router?.detachOnboardingAndAttachMain()
    }
}
