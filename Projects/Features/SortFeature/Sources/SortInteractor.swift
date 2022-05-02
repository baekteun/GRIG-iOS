//
//  SortInteractor.swift
//  SortFeature
//
//  Created by 최형우 on 2022/05/01.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RIBs
import RxSwift

public protocol SortRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SortPresentable: Presentable {
    var listener: SortPresentableListener? { get set }
    var dimmedViewDidTap: Observable<Void> { get }
}

public protocol SortListener: AnyObject {
    func detachSortRIB()
}

final class SortInteractor: PresentableInteractor<SortPresentable>, SortInteractable, SortPresentableListener {

    weak var router: SortRouting?
    weak var listener: SortListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: SortPresentable) {
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
    }
}
