//
//  SortInteractor.swift
//  SortFeature
//
//  Created by 최형우 on 2022/05/01.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RIBs
import RxSwift
import Utility
import Domain
import ThirdPartyLib
import RxRelay

public protocol SortRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SortPresentable: Presentable {
    var listener: SortPresentableListener? { get set }
    var dimmedViewDidTap: Observable<Void> { get }
    var completeButtonDidTap: Observable<Void> { get }
    var criteriaDidChange: Observable<Int> { get }
    var generationDidChange: Observable<Int> { get }
}

public protocol SortListener: AnyObject {
    func detachSortRIB()
}

final class SortInteractor: PresentableInteractor<SortPresentable>, SortInteractable, SortPresentableListener {

    weak var router: SortRouting?
    weak var listener: SortListener?

    private let closure: ((Criteria, Int) -> Void)
    private var criteria = Criteria.contributions
    private var generation = 0
    
    private let criteriaListRelay = BehaviorRelay<[Criteria]>(value: [])
    private let generationListRelay = BehaviorRelay<[GRIGAPI.GrigGenerationQuery.Data.Generation?]>(value: [])
    private let refreshRelay = BehaviorRelay<Bool>(value: false)
    
    private let fetchGenerationListUseCase: FetchGenerationListUseCase
    
    init(
        presenter: SortPresentable,
        closure: @escaping ((Criteria, Int) -> Void),
        fetchGenerationListUseCase: FetchGenerationListUseCase = DIContainer.resolve(FetchGenerationListUseCase.self)!
    ) {
        self.closure = closure
        self.fetchGenerationListUseCase = fetchGenerationListUseCase
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

private extension SortInteractor {
    func bindPresenter() {
        let refreshIndicator = ActivityIndicator()
        presenter.dimmedViewDidTap
            .bind(with: self) { owner, _ in
                owner.listener?.detachSortRIB()
            }
            .disposeOnDeactivate(interactor: self)
        
        presenter.completeButtonDidTap
            .bind(with: self) { owner, _ in
                owner.closure(owner.criteria, owner.generation)
                owner.listener?.detachSortRIB()
            }
            .disposeOnDeactivate(interactor: self)
        
        presenter.criteriaDidChange
            .compactMap { [weak self] in self?.criteriaListRelay.value[$0] }
            .bind(with: self) { owner, criteria in
                owner.criteria = criteria
            }
            .disposeOnDeactivate(interactor: self)
        
        presenter.generationDidChange
            .compactMap { [weak self] in self?.generationListRelay.value[$0]?._id }
            .bind(with: self) { owner, generation in
                owner.generation = generation
            }
            .disposeOnDeactivate(interactor: self)
        
        fetchGenerationListUseCase.execute()
            .trackActivity(refreshIndicator)
            .catchAndReturn([])
            .asObservable()
            .map { [GRIGAPI.GrigGenerationQuery.Data.Generation(_id: 0)] + $0 }
            .bind(to: generationListRelay)
            .disposeOnDeactivate(interactor: self)
        
        Observable.just(Criteria.allCases)
            .bind(to: criteriaListRelay)
            .disposeOnDeactivate(interactor: self)
        
        refreshIndicator
            .asObservable()
            .bind(to: refreshRelay)
            .disposeOnDeactivate(interactor: self)
    }
}

extension SortInteractor {
    var criteriaList: BehaviorRelay<[Criteria]> { criteriaListRelay }
    var generationList: BehaviorRelay<[GRIGAPI.GrigGenerationQuery.Data.Generation?]> { generationListRelay }
    var isLoading: BehaviorRelay<Bool> { refreshRelay }
}
