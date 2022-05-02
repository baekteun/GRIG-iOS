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

public protocol SortRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SortPresentable: Presentable {
    var listener: SortPresentableListener? { get set }
    var dimmedViewDidTap: Observable<Void> { get }
    var completeButtonDidTap: Observable<Void> { get }
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
    }
}
