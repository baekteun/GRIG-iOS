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
import Core
import NVActivityIndicatorView

protocol MainPresentableListener: AnyObject {
    var rankingListSection: BehaviorRelay<[RankTableSection]> { get }
    var sort: BehaviorRelay<(Criteria, Int)> { get }
    var isLoading: BehaviorRelay<Bool> { get }
    var isRefreshing: BehaviorRelay<Bool> { get }
}

final class MainViewController: BaseViewController, MainPresentable, MainViewControllable {
    // MARK: - Properties
    private let activityIndicator = NVActivityIndicatorView(
        frame: .zero,
        type: .pacman,
        color: CoreAsset.Colors.grigPrimaryTextColor.color
    )
    private let rankTableView = UITableView().then {
        $0.register(cellType: RankTableCell.self)
        $0.rowHeight = 75
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.dragInteractionEnabled = false
    }
    private let logoImageView = UIImageView(image: CoreAsset.Images.grigLogo.image.withRenderingMode(.alwaysOriginal))
    private let helpButton = UIButton().then {
        $0.setImage(
            .init(
                systemName: "questionmark.circle.fill")?
                .tintColor(CoreAsset.Colors.girgGray.color)
                .downSample(size: .init(width: 30, height: 30)
            ),
            for: .normal
        )
    }
    private let sortButton = UIButton().then {
        $0.setTitle("contributions ⏐ All ", for: .normal)
        $0.setTitleColor(CoreAsset.Colors.girgGray.color, for: .normal)
        $0.setImage(.init(systemName: "chevron.down"), for: .normal)
        $0.tintColor = CoreAsset.Colors.girgGray.color
        $0.semanticContentAttribute = .forceRightToLeft
    }
    private let refreshControl = UIRefreshControl()
    
    weak var listener: MainPresentableListener?
    private var page: Int = 0
    
    // MARK: - UI
    override func setUp() {
        rankTableView.refreshControl = self.refreshControl
    }
    override func addView() {
        view.addSubviews(logoImageView, helpButton, sortButton, rankTableView, activityIndicator)
    }
    override func setLayout() {
        logoImageView.snp.makeConstraints {
            $0.top.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(108)
            $0.height.equalTo(108*0.3)
        }
        helpButton.snp.makeConstraints {
            $0.centerY.equalTo(logoImageView)
            $0.trailing.equalToSuperview().inset(20)
            $0.size.equalTo(30)
        }
        rankTableView.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(bounds.height*0.1)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        sortButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(rankTableView.snp.top).offset(-8)
        }
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(50)
        }
    }
    override func configureVC() {
        view.backgroundColor = CoreAsset.Colors.grigBackground.color
    }
    override func configureNavigation() {
        let backButton = UIBarButtonItem(title: "back", style: .plain, target: nil, action: nil)
        backButton.tintColor = CoreAsset.Colors.girgGray.color
        self.navigationItem.backBarButtonItem = backButton
    }
    
    // MARK: - Binding
    override func bindListener() {
        self.rankTableView.delegate = nil
        self.rankTableView.dataSource = nil
        
        let rankTableDS = RxTableViewSectionedReloadDataSource<RankTableSection> {  _, tv, ip, item in
            let cell = tv.dequeueReusableCell(for: ip, cellType: RankTableCell.self)
            cell.model = (ip.row + 1 + ip.section * 30, item.0, item.1)
            return cell
        }
        rankTableDS.canMoveRowAtIndexPath = { _, _ in
            return false
        }
        rankTableDS.canEditRowAtIndexPath = { _, _ in
            return false
        }
        
        listener?.rankingListSection
            .bind(to: rankTableView.rx.items(dataSource: rankTableDS))
            .disposed(by: disposeBag)
        
        listener?.sort
            .map {
                if $0.1 == 0 {
                    return "\($0.0.rawValue) ⏐ All"
                } else {
                    return "\($0.0.rawValue) | \($0.1)기"
                }
            }
            .bind(to: sortButton.rx.title())
            .disposed(by: disposeBag)
        
        listener?.isLoading
            .bind(with: self, onNext: { owner, isLoading in
                isLoading ? owner.activityIndicator.startAnimating() : owner.activityIndicator.stopAnimating()
            })
            .disposed(by: disposeBag)
        
        listener?.isRefreshing
            .bind(to: refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
    }
}

extension MainViewController {
    var userDidSelected: Observable<GRIGAPI.GrigEntityQuery.Data.Ranking> {
        self.rankTableView.rx.modelSelected((Criteria, GRIGAPI.GrigEntityQuery.Data.Ranking).self)
            .map(\.1)
            .throttle(.milliseconds(200), latest: true, scheduler: MainScheduler.asyncInstance)
            .asObservable()
    }
    var nextPageTrigger: Observable<Void> {
        self.rankTableView.rx.reachedBottom(offset: 120)
            .asObservable()
    }
    var helpButtonDidTap: Observable<Void> {
        self.helpButton.rx.tap.asObservable()
    }
    var sortButtonDidTap: Observable<Void> {
        self.sortButton.rx.tap.asObservable()
    }
    var refreshTrigger: Observable<Void> {
        self.refreshControl.rx.controlEvent(.valueChanged).asObservable()
    }
}

extension MainViewController {
    func CustomPresent(_ viewController: ViewControllable) {
        viewController.uiviewController.modalPresentationStyle = .overFullScreen
        viewController.uiviewController.modalTransitionStyle = .crossDissolve
        self.topViewControllable.present(viewController, animated: true, completion: nil)
    }
}
