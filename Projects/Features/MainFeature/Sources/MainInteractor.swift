import RIBs
import RxSwift
import RxRelay
import Domain
import Utility

public protocol MainRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol MainPresentable: Presentable {
    var listener: MainPresentableListener? { get set }
    var viewWillAppearTrigger: Observable<Void> { get }
}

public protocol MainListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class MainInteractor: PresentableInteractor<MainPresentable>, MainInteractable, MainPresentableListener {

    weak var router: MainRouting?
    weak var listener: MainListener?
    
    private var criteria = Criteria.contributions
    
    private var rankingListSectionRelay = BehaviorRelay<[RankTableSection]>(value: [])
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: MainPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.viewWillAppearTrigger
            .map { _ in [
                .init(
                    name: "name",
                    nickname: "nickname",
                    bio: "bio",
                    avatarUrl: "https://avatars.githubusercontent.com/u/74440939?v=4",
                    pullRequests: 12,
                    stared: 2,
                    issues: 27,
                    generation: 5,
                    forked: 3,
                    following: 336,
                    followers: 2,
                    contributions: 4003
                )
            ]}
            .map { [weak self] entity in
                entity.map { (self?.criteria ?? .contributions, $0) }
            }
            .map { [RankTableSection(items: $0)] }
            .bind(to: rankingListSectionRelay)
            .disposeOnDeactivate(interactor: self)
    }

    override func willResignActive() {
        super.willResignActive()
    }
}

extension MainInteractor {
    var rankingListSection: BehaviorRelay<[RankTableSection]> { rankingListSectionRelay }
}
