import UIKit
import RIBs
import RxSwift
import RxRelay
import CommonFeature
import Then
import Reusable
import Utility
import SnapKit
import Domain
import RxDataSources

protocol MainPresentableListener: AnyObject {
    var rankingList: BehaviorRelay<[GRIGEntity]> { get }
}

final class MainViewController: BaseViewController, MainPresentable, MainViewControllable {
    // MARK: - Properties
    private let rankTableView = UITableView().then {
        $0.register(cellType: RankTableCell.self)
//        $0.separatorStyle = .none
        $0.rowHeight = UITableView.automaticDimension
    }
    private let rankCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.isHidden = true
        $0.register(cellType: RankCollectionCell.self)
    }

    weak var listener: MainPresentableListener?
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation == .portrait {
            rankTableView.isHidden = false
            rankCollectionView.isHidden = true
        } else if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            rankTableView.isHidden = true
            rankCollectionView.isHidden = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bindPresenter()
    }
    
    // MARK: - UI
    override func addView() {
        view.addSubviews(rankTableView, rankCollectionView)
    }
    override func setLayout() {
        rankTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    override func configureVC() {
        
    }
    
    // MARK: - Binding
    override func bindPresenter() {
        let rankTableDS = RxTableViewSectionedReloadDataSource<RankTableSection> { _, tv, ip, item in
            let cell = tv.dequeueReusableCell(for: ip, cellType: RankTableCell.self)
            cell.model = (ip.row+1, item)
            return cell
        }
        
        listener?.rankingList
            .map { [RankTableSection.init(items: $0)] }
            .bind(to: rankTableView.rx.items(dataSource: rankTableDS))
            .disposed(by: disposeBag)
    }
}

extension MainViewController {
    var viewWillAppearTrigger: Observable<Void> {
        self.rx.viewWillAppear.asObservable()
    }
}

