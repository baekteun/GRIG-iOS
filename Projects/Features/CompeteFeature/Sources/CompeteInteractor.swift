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
import Utility

public protocol CompeteRouting: ViewableRouting {
    func presentAlertWithTextField(
        title: String?,
        message: String?,
        initialFirstTFValue: String?,
        initialSecondTFValue: String?,
        completion: @escaping ((String, String) -> Void)
    )
}

protocol CompetePresentable: Presentable {
    var listener: CompetePresentableListener? { get set }
    
    var viewWillDisAppearTrigger: Observable<Void> { get }
    var viewDidAppearTrigger: Observable<Void> { get }
    var changeIDButtonDidTap: Observable<Void> { get }
}

public protocol CompeteListener: AnyObject {
    func detachCompete()
}

final class CompeteInteractor: PresentableInteractor<CompetePresentable>, CompeteInteractable, CompetePresentableListener {

    weak var router: CompeteRouting?
    weak var listener: CompeteListener?
    
    private let competeUserRelay = PublishRelay<(GRIGAPI.GithubUserQuery.Data.User, GRIGAPI.GithubUserQuery.Data.User)>()
    private let totalContributionsRelay = PublishRelay<(Int, Int)>()
    private let refreshRelay = BehaviorRelay<Bool>(value: false)
        
    private let fetchUesrInfoUseCase: FetchUserInfoUseCase
    private let fetchUserTotalContributionUseCase: FetchUserTotalContributionUseCase
    private let fetchMyUserIDUseCase: FetchMyUserIDUseCase
    private let fetchCompeteUserIDUseCase: FetchCompeteUserIDUseCase
    private let saveMyUserIDUseCase: SaveMyUserIDUseCase
    private let saveCompeteUserIDUseCase: SaveCompeteUserIDUseCase

    private let my: String
    private let compete: String
    
    init(
        presenter: CompetePresentable,
        fetchUesrInfoUseCase: FetchUserInfoUseCase = DIContainer.resolve(FetchUserInfoUseCase.self)!,
        fetchUserTotalContributionUseCase: FetchUserTotalContributionUseCase = DIContainer.resolve(FetchUserTotalContributionUseCase.self)!,
        fetchMyUserIDUseCase: FetchMyUserIDUseCase = DIContainer.resolve(FetchMyUserIDUseCase.self)!,
        fetchCompeteUserIDUseCase: FetchCompeteUserIDUseCase = DIContainer.resolve(FetchCompeteUserIDUseCase.self)!,
        saveMyUserIDUseCase: SaveMyUserIDUseCase = DIContainer.resolve(SaveMyUserIDUseCase.self)!,
        saveCompeteUserIDUseCase: SaveCompeteUserIDUseCase = DIContainer.resolve(SaveCompeteUserIDUseCase.self)!
    ) {
        self.fetchUesrInfoUseCase = fetchUesrInfoUseCase
        self.fetchUserTotalContributionUseCase = fetchUserTotalContributionUseCase
        self.fetchMyUserIDUseCase = fetchMyUserIDUseCase
        self.fetchCompeteUserIDUseCase = fetchCompeteUserIDUseCase
        self.saveMyUserIDUseCase = saveMyUserIDUseCase
        self.saveCompeteUserIDUseCase = saveCompeteUserIDUseCase
        self.my = fetchMyUserIDUseCase.execute() ?? ""
        self.compete = fetchCompeteUserIDUseCase.execute() ?? ""
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
    var totalContributions: PublishRelay<(Int, Int)> { totalContributionsRelay }
    var isLoading: BehaviorRelay<Bool> { refreshRelay }
}

private extension CompeteInteractor {
    func bindPresenter() {
        let refreshIndicator = ActivityIndicator()
        
        refreshIndicator
            .asObservable()
            .bind(to: refreshRelay)
            .disposeOnDeactivate(interactor: self)
        
        presenter.viewWillDisAppearTrigger
            .bind(with: self) { owner, _ in
                owner.listener?.detachCompete()
            }
            .disposeOnDeactivate(interactor: self)
        
        presenter.changeIDButtonDidTap
            .bind(with: self) { owner, _ in
                owner.router?.presentAlertWithTextField(
                    title: "아이디 변경",
                    message: nil,
                    initialFirstTFValue: owner.my,
                    initialSecondTFValue: owner.compete,
                    completion: { [weak self] myID, competeID in
                        self?.saveMyUserIDUseCase.execute(value: myID)
                        self?.saveCompeteUserIDUseCase.execute(value: competeID)
                    })
            }
            .disposeOnDeactivate(interactor: self)
        
        let to = Date().toISO8601()
        let from = Date().addingTimeInterval(-(86400 * 4)).toISO8601()
        
        presenter.viewDidAppearTrigger
            .withUnretained(self)
            .flatMap { owner, _ in
                Observable.zip(
                    owner.fetchUserTotalContributionUseCase.execute(
                        login: owner.my
                    ).trackActivity(refreshIndicator).asObservable(),
                    owner.fetchUserTotalContributionUseCase.execute(
                        login: owner.compete
                    ).trackActivity(refreshIndicator).asObservable()
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
            .bind(to: totalContributionsRelay)
            .disposeOnDeactivate(interactor: self)
        
        presenter.viewDidAppearTrigger
            .withUnretained(self)
            .flatMap { owner, _ in
                Observable.zip(
                    owner.fetchUesrInfoUseCase.execute(
                        login: owner.my, from: from, to: to
                    ).trackActivity(refreshIndicator).asObservable(),
                    owner.fetchUesrInfoUseCase.execute(
                        login: owner.compete, from: from, to: to
                    ).trackActivity(refreshIndicator).asObservable()
                )
            }
            .catch({ _ in
                return .empty()
            })
            .bind(to: competeUserRelay)
            .disposeOnDeactivate(interactor: self)
    }
}
