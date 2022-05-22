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
    func attachCompete()
    func detachCompete()
    func detachUserAndAttachCompete()
    func presentActionSheet()
}

protocol MainPresentable: Presentable {
    var listener: MainPresentableListener? { get set }
    var userDidSelected: Observable<GRIGAPI.GrigEntityQuery.Data.Ranking> { get }
    var nextPageTrigger: Observable<Void> { get }
    var helpButtonDidTap: Observable<Void> { get }
    var sortButtonDidTap: Observable<Void> { get }
    var refreshTrigger: Observable<Void> { get }
    var competeButtonDidTap: Observable<Void> { get }
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
    
    private let rankingListSectionRelay = BehaviorRelay<[RankTableSection]>(value: [])
    private let sortRelay = BehaviorRelay<(Criteria, Int)>(value: (Criteria.contributions, 0))
    private let isLoadingRelay = BehaviorRelay<Bool>(value: false)
    private let isRefreshingRelay = BehaviorRelay<Bool>(value: false)
    
    private let fetchRankingListUseCase: FetchRankingListUseCase
    private let saveMyUserIDUseCase: SaveMyUserIDUseCase
    private let saveCompeteUserIDUseCase: SaveCompeteUserIDUseCase
    
    init(
        presenter: MainPresentable,
        fetchRankingListUseCase: FetchRankingListUseCase = DIContainer.resolve(FetchRankingListUseCase.self)!,
        saveMyUserIDUseCase: SaveMyUserIDUseCase = DIContainer.resolve(SaveMyUserIDUseCase.self)!,
        saveCompeteUserIDUseCase: SaveCompeteUserIDUseCase = DIContainer.resolve(SaveCompeteUserIDUseCase.self)!
    ) {
        self.fetchRankingListUseCase = fetchRankingListUseCase
        self.saveMyUserIDUseCase = saveMyUserIDUseCase
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
    func detachCompete() {
        router?.detachCompete()
    }
    func detachUserAndAttachCompete() {
        router?.detachUserAndAttachCompete()
    }
}

extension MainInteractor {
    var rankingListSection: BehaviorRelay<[RankTableSection]> { rankingListSectionRelay }
    var sort: BehaviorRelay<(Criteria, Int)> { sortRelay }
    var isLoading: BehaviorRelay<Bool>  { isLoadingRelay }
    var isRefreshing: BehaviorRelay<Bool> { isRefreshingRelay }
}

private extension MainInteractor {
    func bindPresenter() {
        let isLoadingIndicator = ActivityIndicator()
        let isRefreshingIndicator = ActivityIndicator()
        
        initialFetch(tracking: isLoadingIndicator)
        
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
                ).trackActivity(isLoadingIndicator)
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
                    owner.initialFetch(tracking: isLoadingIndicator)
                })
            }
            .disposeOnDeactivate(interactor: self)
        
        presenter.refreshTrigger
            .bind(with: self) { owner, _ in
                owner.rankingListSectionRelay.accept([])
                owner.page = 1
                owner.initialFetch(tracking: isRefreshingIndicator)
            }
            .disposeOnDeactivate(interactor: self)
        
        presenter.competeButtonDidTap
            .bind(with: self) { owner, _ in
                owner.router?.attachCompete()
            }
            .disposeOnDeactivate(interactor: self)
        
        isLoadingIndicator
            .asObservable()
            .bind(to: isLoadingRelay)
            .disposeOnDeactivate(interactor: self)
        
        isRefreshingIndicator
            .asObservable()
            .bind(to: isRefreshingRelay)
            .disposeOnDeactivate(interactor: self)
    }
    private func initialFetch(tracking: ActivityIndicator) {
        fetchRankingListUseCase.execute(
            criteria: criteria,
            count: count,
            page: page,
            generation: generation
        )
        .trackActivity(tracking)
        .map { [weak self] entity in
            entity.map { (self?.criteria ?? .contributions, $0 ?? .init()) }
        }
        .catchAndReturn([])
        .map { [RankTableSection(items: $0)] }
        .asObservable()
        .bind(to: rankingListSectionRelay)
        .disposeOnDeactivate(interactor: self)
    }
}
