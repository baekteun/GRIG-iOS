//
//  UserInteractor.swift
//  UserFeature
//
//  Created by 최형우 on 2022/04/27.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RIBs
import RxSwift
import Domain
import ThirdPartyLib

public protocol UserRouting: ViewableRouting {
    func openGithubProfile(url: String)
}

protocol UserPresentable: Presentable {
    var listener: UserPresentableListener? { get set }
    
    var viewWillDisAppearTrigger: Observable<Void> { get }
    var githubButtonDidTap: Observable<String> { get }
    var competeButtonDidTap: Observable<String> { get }
}

public protocol UserListener: AnyObject {
    func detachUserRIB()
}

final class UserInteractor: PresentableInteractor<UserPresentable>, UserInteractable, UserPresentableListener {

    weak var router: UserRouting?
    weak var listener: UserListener?
    
    private let saveCompeteUserIDUseCase: SaveCompeteUserIDUseCase

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(
        presenter: UserPresentable,
        saveCompeteUserIDUseCase: SaveCompeteUserIDUseCase = DIContainer.resolve(SaveCompeteUserIDUseCase.self)!
    ) {
        self.saveCompeteUserIDUseCase = saveCompeteUserIDUseCase
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
        
        presenter.competeButtonDidTap
            .bind(with: self) { owner, name in
                owner.saveCompeteUserIDUseCase.execute(value: name)
                owner.router?.viewControllable.showLoaf(
                    "\(name)님이 경쟁자로 등록되었습니다.",
                    state: .success,
                    location: .top
                )
            }
            .disposeOnDeactivate(interactor: self)
    }
}
