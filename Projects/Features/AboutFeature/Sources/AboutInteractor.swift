//
//  AboutInteractor.swift
//  AboutFeature
//
//  Created by 최형우 on 2022/05/02.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RIBs
import RxSwift

public protocol AboutRouting: ViewableRouting {
    func presentMailScene()
}

protocol AboutPresentable: Presentable {
    var listener: AboutPresentableListener? { get set }
    
    var viewDidDisAppearTrigger: Observable<Void> { get }
    var mailDidTap: Observable<Void> { get }
}

public protocol AboutListener: AnyObject {
    func detachAboutRIB()
}

final class AboutInteractor: PresentableInteractor<AboutPresentable>, AboutInteractable, AboutPresentableListener {

    weak var router: AboutRouting?
    weak var listener: AboutListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: AboutPresentable) {
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

private extension AboutInteractor {
    func bindPresenter() {
        presenter.viewDidDisAppearTrigger
            .bind(with: self) { owner, _ in
                owner.listener?.detachAboutRIB()
            }
            .disposeOnDeactivate(interactor: self)
        
        presenter.mailDidTap
            .bind(with: self) { owner, _ in
                owner.router?.presentMailScene()
            }
            .disposeOnDeactivate(interactor: self)
    }
}
