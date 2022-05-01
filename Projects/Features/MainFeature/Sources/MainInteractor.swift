import RIBs
import RxSwift
import RxRelay
import Domain
import Utility
import Swinject
import CommonFeature
import InjectManager
import ThirdPartyLib

public protocol MainRouting: ViewableRouting {
    func attachUser(user: GRIGAPI.GrigEntityQuery.Data.Ranking)
    func detachUser()
}

protocol MainPresentable: Presentable {
    var listener: MainPresentableListener? { get set }
    var viewWillAppearTrigger: Observable<Void> { get }
    var userDidSelected: Observable<GRIGAPI.GrigEntityQuery.Data.Ranking> { get }
}

public protocol MainListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class MainInteractor: PresentableInteractor<MainPresentable>, MainInteractable, MainPresentableListener {

    weak var router: MainRouting?
    weak var listener: MainListener?
    
    private var criteria = Criteria.contributions
    private var page = 1
    private var generation = 0
    
    private var rankingListSectionRelay = BehaviorRelay<[RankTableSection]>(value: [])
    
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
}

extension MainInteractor {
    var rankingListSection: BehaviorRelay<[RankTableSection]> { rankingListSectionRelay }
}

private extension MainInteractor {
    func bindPresenter() {
        presenter.viewWillAppearTrigger
            .withUnretained(self)
            .flatMap({ owner, _ in
                owner.fetchRankingListUseCase.execute(
                    criteria: owner.criteria,
                    count: 30,
                    page: owner.page,
                    generation: owner.generation
                )
            })
            .map { [weak self] entity in
                entity.map { (self?.criteria ?? .contributions, $0 ?? .init()) }
            }
            .map { [RankTableSection(items: $0)] }
            .bind(to: rankingListSectionRelay)
            .disposeOnDeactivate(interactor: self)
        
        presenter.userDidSelected
            .bind(with: self, onNext: { owner, user in
                owner.router?.attachUser(user: user)
            })
            .disposeOnDeactivate(interactor: self)
    }
}
