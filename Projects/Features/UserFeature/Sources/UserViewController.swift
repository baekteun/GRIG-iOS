import RIBs
import RxSwift
import UIKit
import PanModal
import Then
import Core
import Utility
import CommonFeature
import SnapKit
import Domain
import Kingfisher

protocol UserPresentableListener: AnyObject {
    
}

final class UserViewController: BaseViewController, UserPresentable, UserViewControllable {
    // MARK: - Properties
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    private let contentView = UIView()
    private let userProfileImageView = UIImageView().then {
        $0.layer.cornerRadius = 35
        $0.clipsToBounds = true
    }
    private let nicknameLabel = UILabel().then {
        $0.textColor = CoreAsset.Colors.grigPrimaryTextColor.color
        $0.font = .systemFont(ofSize: 26, weight: .bold)
    }
    private let nameLabel = UILabel().then {
        $0.textColor = CoreAsset.Colors.grigSecondaryTextColor.color
        $0.font = .systemFont(ofSize: 16, weight: .regular)
    }
    private let followStatView = UserStatView(stat: .following, value: 0)
    private let firstSeparatorView = UIView().then {
        $0.backgroundColor = CoreAsset.Colors.girgGray.color
    }
    private let followerStatView = UserStatView(stat: .follower, value: 0)
    private let secondSeparatorView = UIView().then {
        $0.backgroundColor = CoreAsset.Colors.girgGray.color
    }
    private let commitStatView = UserStatView(stat: .commit, value: 0)
    private let statStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 40
    }
    private let bioLabel = PaddingLabel(padding: .init(top: 12, left: 24, bottom: 12, right: 24)).then {
        $0.numberOfLines = 0
        $0.backgroundColor = CoreAsset.Colors.grigWhite.color
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
    }
    private let githubButton = UserCustomButton(icon: CoreAsset.Images.grigGithubIcon.image, title: "Github")
    private let competeButton = UserCustomButton(icon: CoreAsset.Images.grigCompeteIcon.image, title: "Compete")
    private let user: GRIGAPI.GrigEntityQuery.Data.Ranking
    
    weak var listener: UserPresentableListener?
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .init()
    }
    
    // MARK: - Init
    init(user: GRIGAPI.GrigEntityQuery.Data.Ranking) {
        self.user = user
        super.init()
        setUpUser()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        panModalTransition(to: .shortForm)
    }
    
    // MARK: - UI
    override func addView() {
        statStackView.addArrangeSubviews(followStatView, firstSeparatorView, followerStatView, secondSeparatorView, commitStatView)
        view.addSubviews(scrollView)
        scrollView.addSubviews(contentView)
        contentView.addSubviews(userProfileImageView, nicknameLabel, nameLabel, statStackView, bioLabel, githubButton, competeButton)
    }
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.width.top.bottom.equalToSuperview()
        }
        userProfileImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(45)
            $0.size.equalTo(70)
        }
        nicknameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(userProfileImageView.snp.bottom)
        }
        nameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(nicknameLabel.snp.bottom)
        }
        firstSeparatorView.snp.makeConstraints {
            $0.width.equalTo(0.6)
            $0.height.equalTo(30)
        }
        secondSeparatorView.snp.makeConstraints {
            $0.width.equalTo(0.6)
            $0.height.equalTo(30)
        }
        statStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(nameLabel.snp.bottom).offset(20)
        }
        githubButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(34)
            $0.height.equalTo(60)
            $0.bottom.equalTo(competeButton.snp.top).offset(-16)
        }
        competeButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(34)
            $0.height.equalTo(60)
            $0.bottom.equalToSuperview().inset(20)
        }
        bioLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(34)
            $0.top.equalTo(statStackView.snp.bottom).offset(24)
            $0.bottom.equalTo(githubButton.snp.top).offset(-12)
            $0.height.greaterThanOrEqualTo(70)
        }
    }
    override func configureVC() {
        view.backgroundColor = CoreAsset.Colors.grigBackground.color
    }
    
    override func bindListener() {
        
    }
}

// MARK: - PanModal
extension UserViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        scrollView
    }
    var shortFormHeight: PanModalHeight {
        .contentHeight(scrollView.contentSize.height)
    }
    var longFormHeight: PanModalHeight {
        .maxHeightWithTopInset(view.safeAreaInsets.top + 50)
    }
}

// MARK: - UserPresentable
extension UserViewController {
    var viewDidDisAppearTrigger: Observable<Void> {
        self.rx.viewDidDisAppear
            .asObservable()
    }
    var githubButtonDidTap: Observable<String> {
        self.githubButton.rx.tap
            .debounce(.microseconds(200), scheduler: MainScheduler.asyncInstance)
            .asObservable()
            .compactMap { [weak self] _ in self?.user.nickname }
            .map { "https://github.com/\($0)" }
    }
    var competeButtonDidTap: Observable<String> {
        self.competeButton.rx.tap
            .debounce(.microseconds(200), scheduler: MainScheduler.asyncInstance)
            .asObservable()
            .compactMap { [weak self] _ in self?.user.nickname }
    }
}

// MARK: - Method
private extension UserViewController {
    func setUpUser() {
        userProfileImageView.kf.setImage(with: URL(string: user.avatarUrl ?? "") ?? .none,
                                         placeholder: UIImage(),
                                         options: [])
        nicknameLabel.text = "\(user.nickname ?? "")(\(user.generation ?? 0)기)"
        nameLabel.text = user.name
        followStatView.setStatValue(value: user.following ?? 0)
        followerStatView.setStatValue(value: user.followers ?? 0)
        commitStatView.setStatValue(value: user.contributions ?? 0)
        bioLabel.text = user.bio
    }
}
