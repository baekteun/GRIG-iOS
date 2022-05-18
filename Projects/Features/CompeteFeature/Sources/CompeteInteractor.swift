//
//  CompeteInteractor.swift
//  CompeteFeatureDemoApp
//
//  Created by 최형우 on 2022/05/16.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RIBs
import RxSwift
import Domain
import RxRelay
import Foundation
import ThirdPartyLib

public protocol CompeteRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol CompetePresentable: Presentable {
    var listener: CompetePresentableListener? { get set }
    
    var viewWillDisAppearTrigger: Observable<Void> { get }
    var viewWillAppearTrigger: Observable<Void> { get }
}

public protocol CompeteListener: AnyObject {
    func detachCompete()
}

final class CompeteInteractor: PresentableInteractor<CompetePresentable>, CompeteInteractable, CompetePresentableListener {

    weak var router: CompeteRouting?
    weak var listener: CompeteListener?
    
    private let competeUserRelay = PublishRelay<(GRIGAPI.GithubUserQuery.Data.User, GRIGAPI.GithubUserQuery.Data.User)>()
        
    private let fetchUesrInfoUseCase: FetchUserInfoUseCase
    private let saveMyUserIDUseCase: SaveMyUserIDUseCase
    private let saveCompeteUserIDUseCase: SaveCompeteUserIDUseCase

    private let my: String
    private let compete: String
    
    init(
        presenter: CompetePresentable,
        fetchUesrInfoUseCase: FetchUserInfoUseCase = DIContainer.resolve(FetchUserInfoUseCase.self)!,
        saveMyUserIDUseCase: SaveMyUserIDUseCase = DIContainer.resolve(SaveMyUserIDUseCase.self)!,
        saveCompeteUserIDUseCase: SaveCompeteUserIDUseCase = DIContainer.resolve(SaveCompeteUserIDUseCase.self)!,
        my: String,
        compete: String
    ) {
        self.fetchUesrInfoUseCase = fetchUesrInfoUseCase
        self.saveMyUserIDUseCase = saveMyUserIDUseCase
        self.saveCompeteUserIDUseCase = saveCompeteUserIDUseCase
        self.my = my
        self.compete = compete
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

extension CompeteInteractor {
    var competeUser: PublishRelay<(GRIGAPI.GithubUserQuery.Data.User, GRIGAPI.GithubUserQuery.Data.User)> { competeUserRelay }
}

private extension CompeteInteractor {
    func bindPresenter() {
        presenter.viewWillDisAppearTrigger
            .bind(with: self) { owner, _ in
                owner.listener?.detachCompete()
            }
            .disposeOnDeactivate(interactor: self)
        
        let to = Date().toISO8601()
        let from = Date().addingTimeInterval(-(86400 * 5)).toISO8601()
        presenter.viewWillAppearTrigger
            .withUnretained(self)
            .flatMap { owner, _ in
                Observable.zip(
                    owner.fetchUesrInfoUseCase.execute(
                        login: owner.my, from: from, to: to
                    ).asObservable(),
                    owner.fetchUesrInfoUseCase.execute(
                        login: owner.compete, from: from, to: to
                    ).asObservable()
                )
            }
            .catch({ [weak self] _ in
                self?.router?.viewControllable.topViewControllable.presentFailureAlert(
                    title: "유저 정보를 가져오는데 실패했습니다.",
                    message: "아이디를 확인해주세요!",
                    style: .alert
                )
                return .empty()
            })
            .bind(to: competeUserRelay)
            .disposeOnDeactivate(interactor: self)
    }
}
