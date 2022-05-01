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
    func openGithubProfile(url: String)
}

protocol UserPresentable: Presentable {
    var listener: UserPresentableListener? { get set }
    
    var viewWillDisAppearTrigger: Observable<Void> { get }
    var githubButtonDidTap: Observable<String> { get }
}

public protocol UserListener: AnyObject {
    func detachUserRIB()
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
        bindPresenter()
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}

private extension UserInteractor {
    func bindPresenter() {
        presenter.viewWillDisAppearTrigger
            .bind(with: self) { owner, _ in
                owner.listener?.detachUserRIB()
            }
            .disposeOnDeactivate(interactor: self)
        
        presenter.githubButtonDidTap
            .bind(with: self) { owner, url in
                owner.router?.openGithubProfile(url: url)
            }
            .disposeOnDeactivate(interactor: self)
    }
}
