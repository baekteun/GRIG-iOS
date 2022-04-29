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
    private let rankCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.isHidden = true
        $0.register(cellType: RankCollectionCell.self)
    }
    private let logoImageView = UIImageView(image: CoreAsset.Images.grigLogo.image.withRenderingMode(.alwaysOriginal))
    private let helpButton = UIButton().then {
        $0.setImage(.init(systemName: "questionmark.circle.fill"), for: .normal)
        $0.tintColor = .init(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.6)
    }
    private let sortButton = UIButton().then {
        $0.setTitle("contributions | All", for: .normal)
        $0.setTitleColor(.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.6), for: .normal)
        $0.setImage(.init(systemName: "chevron.down"), for: .normal)
        $0.tintColor = .init(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.6)
        $0.semanticContentAttribute = .forceRightToLeft
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
        view.addSubviews(rankTableView, logoImageView, helpButton, sortButton)
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
            $0.trailing.equalTo(rankTableView.snp.trailing).inset(20)
            $0.bottom.equalTo(rankTableView.snp.top).offset(-8)
        }
    }
    override func configureVC() {
        view.backgroundColor = CoreAsset.Colors.grigBackground.color
    }
    
    // MARK: - Binding
    override func bindPresenter() {
        let rankTableDS = RxTableViewSectionedReloadDataSource<RankTableSection> { ds, tv, ip, item in
            let cell = tv.dequeueReusableCell(for: ip, cellType: RankTableCell.self)
            cell.model = (ip.row+1, item.0, item.1)
            return cell
        }
        
        listener?.rankingListSection
            .bind(to: rankTableView.rx.items(dataSource: rankTableDS))
            .disposed(by: disposeBag)
    }
}

extension MainViewController {
    var viewWillAppearTrigger: Observable<Void> {
        self.rx.viewWillAppear.asObservable()
    }
}

