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

protocol MainPresentableListener: AnyObject {
    var rankingListSection: BehaviorRelay<[RankTableSection]> { get }
}

final class MainViewController: BaseViewController, MainPresentable, MainViewControllable {
    // MARK: - Properties
    private let rankTableView = UITableView().then {
        $0.register(cellType: RankTableCell.self)
        $0.rowHeight = 75
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
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
    weak var listener: MainPresentableListener?
    private var page: Int = 0
    
    // MARK: - UI
    override func addView() {
        view.addSubviews(logoImageView, helpButton, sortButton, rankTableView)
    }
    override func setLayout() {
        logoImageView.snp.makeConstraints {
            $0.top.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(bounds.width*0.288)
            $0.height.equalTo(bounds.width*0.288*0.3)
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
    }
    override func configureVC() {
        view.backgroundColor = CoreAsset.Colors.grigBackground.color
    }
    
    // MARK: - Binding
    override func bindPresenter() {
        self.rankTableView.delegate = nil
        self.rankTableView.dataSource = nil
        
        let rankTableDS = RxTableViewSectionedReloadDataSource<RankTableSection> {  _, tv, ip, item in
            let cell = tv.dequeueReusableCell(for: ip, cellType: RankTableCell.self)
            cell.model = (ip.row + 1 + ip.section * 30, item.0, item.1)
            return cell
        }
        
        listener?.rankingListSection
            .bind(to: rankTableView.rx.items(dataSource: rankTableDS))
            .disposed(by: disposeBag)
    }
}

extension MainViewController {
    var userDidSelected: Observable<GRIGAPI.GrigEntityQuery.Data.Ranking> {
        self.rankTableView.rx.modelSelected((Criteria, GRIGAPI.GrigEntityQuery.Data.Ranking).self)
            .map(\.1)
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
}

extension MainViewController {
    func CustomPresent(_ viewController: ViewControllable) {
        viewController.uiviewController.modalPresentationStyle = .overFullScreen
        viewController.uiviewController.modalTransitionStyle = .crossDissolve
        self.topViewControllable.present(viewController, animated: true, completion: nil)
    }
}
