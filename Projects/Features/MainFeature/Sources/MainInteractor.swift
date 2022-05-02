import RIBs
import RxSwift
import RxRelay
import Domain
import Utility
import Swinject
import CommonFeature
import ThirdPartyLib

public protocol MainRouting: ViewableRouting {
    func attachUser(user: GRIGAPI.GrigEntityQuery.Data.Ranking)
    func detachUser()
    func attachSort(closure: @escaping ((Criteria, Int) -> Void))
    func detachSort()
    func attachAbout()
    func detachAbout()
    func presentActionSheet()
}

protocol MainPresentable: Presentable {
    var listener: MainPresentableListener? { get set }
    var userDidSelected: Observable<GRIGAPI.GrigEntityQuery.Data.Ranking> { get }
    var nextPageTrigger: Observable<Void> { get }
    var helpButtonDidTap: Observable<Void> { get }
    var sortButtonDidTap: Observable<Void> { get }
}

public protocol MainListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class MainInteractor: PresentableInteractor<MainPresentable>, MainInteractable, MainPresentableListener {

    weak var router: MainRouting?
    weak var listener: MainListener?
    
    private var criteria = Criteria.contributions
    private let count = 30
    private var page = 1
    private var generation = 0
    
    private var rankingListSectionRelay = BehaviorRelay<[RankTableSection]>(value: [])
    private var sortRelay = BehaviorRelay<(Criteria, Int)>(value: (Criteria.contributions, 0))
    
    private let fetchRankingListUseCase: FetchRankingListUseCase
    
    init(
        presenter: MainPresentable,
        fetchRankingListUseCase: FetchRankingListUseCase = DIContainer.resolve(FetchRankingListUseCase.self)!
    ) {
        self.fetchRankingListUseCase = fetchRankingListUseCase
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

extension MainInteractor {
    func detachUserRIB() {
        router?.detachUser()
    }
    func detachSortRIB() {
        router?.detachSort()
    }
    func detachAboutRIB() {
        router?.detachAbout()
    }
}

extension MainInteractor {
    var rankingListSection: BehaviorRelay<[RankTableSection]> { rankingListSectionRelay }
    var sort: BehaviorRelay<(Criteria, Int)> { sortRelay}
}

private extension MainInteractor {
    func bindPresenter() {
        initialFetch()
        
        presenter.userDidSelected
            .bind(with: self, onNext: { owner, user in
                owner.router?.attachUser(user: user)
            })
            .disposeOnDeactivate(interactor: self)
        
        presenter.nextPageTrigger
            .withUnretained(self)
            .do(onNext: { owner, _ in
                owner.page += 1
            }).flatMap({ owner, _ in
                owner.fetchRankingListUseCase.execute(
                    criteria: owner.criteria,
                    count: owner.count,
                    page: owner.page,
                    generation: owner.generation
                )
            }).map { [weak self] entity in
                entity.map { (self?.criteria ?? .contributions, $0 ?? .init()) }
            }
            .catchAndReturn([])
            .map { [RankTableSection(items: $0)] }
            .map { [weak self] added in (self?.rankingListSectionRelay.value ?? []) + added }
            .bind(to: rankingListSectionRelay)
            .disposeOnDeactivate(interactor: self)
        
        presenter.helpButtonDidTap
            .bind(with: self) { owner, _ in
                owner.router?.presentActionSheet()
            }
            .disposeOnDeactivate(interactor: self)
        
        presenter.sortButtonDidTap
            .bind(with: self) { owner, _ in
                owner.router?.attachSort(closure: { criteria, generation in
                    owner.sortRelay.accept((criteria, generation))
                    owner.rankingListSectionRelay.accept([])
                    owner.page = 1
                    owner.criteria = criteria
                    owner.generation = generation
                    owner.initialFetch()
                })
            }
            .disposeOnDeactivate(interactor: self)
    }
    func initialFetch() {
        fetchRankingListUseCase.execute(
            criteria: criteria,
            count: count,
            page: page,
            generation: generation
        ).map { [weak self] entity in
            entity.map { (self?.criteria ?? .contributions, $0 ?? .init()) }
        }
        .catchAndReturn([])
        .map { [RankTableSection(items: $0)] }
        .asObservable()
        .bind(to: rankingListSectionRelay)
        .disposeOnDeactivate(interactor: self)
    }
}
