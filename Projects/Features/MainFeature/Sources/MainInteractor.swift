import RIBs
import RxSwift
import RxRelay
import Domain

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
    
    private var rankingListRelay = BehaviorRelay<[GRIGEntity]>(value: [])
    
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
                GRIGEntity.init(name: "asdf", nickname: "asdf", generation: 2, bio: "대충대충대충\n대충대충", avatarUrl: "https://avatars.githubusercontent.com/u/74440939?v=4", result: 68)
            ]}
            .bind(to: rankingListRelay)
            .disposeOnDeactivate(interactor: self)
    }

    override func willResignActive() {
        super.willResignActive()
    }
}

extension MainInteractor {
    var rankingList: BehaviorRelay<[GRIGEntity]> { rankingListRelay }
}
