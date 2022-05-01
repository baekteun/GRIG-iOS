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
    private let userProfileImageView = UIImageView().then {
        $0.layer.cornerRadius = 35
        $0.clipsToBounds = true
    }
    private let nameLabel = UILabel().then {
        $0.textColor = CoreAsset.Colors.grigPrimaryTextColor.color
        $0.font = .systemFont(ofSize: 26, weight: .bold)
    }
    private let nicknameLabel = UILabel().then {
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
    
    weak var listener: UserPresentableListener?
    
    // MARK: - Init
    init(user: GRIGAPI.GrigEntityQuery.Data.Ranking) {
        super.init()
        setUpUser(user: user)
    }
    
    // MARK: - UI
    override func addView() {
        statStackView.addArrangeSubviews(followStatView, firstSeparatorView, followerStatView, secondSeparatorView, commitStatView)
        view.addSubviews(userProfileImageView, nameLabel, nicknameLabel, statStackView)
    }
    override func setLayout() {
        userProfileImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(45)
            $0.size.equalTo(70)
        }
        nameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(userProfileImageView.snp.bottom)
        }
        nicknameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(nameLabel.snp.bottom)
        }
        firstSeparatorView.snp.makeConstraints {
            $0.width.equalTo(0.25)
            $0.height.equalTo(30)
        }
        secondSeparatorView.snp.makeConstraints {
            $0.width.equalTo(0.25)
            $0.height.equalTo(30)
        }
        statStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(20)
        }
    }
    override func configureVC() {
        view.backgroundColor = CoreAsset.Colors.grigBackground.color
    }
    
    override func bindPresenter() {
        
    }
}

// MARK: - PanModal
extension UserViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        nil
    }
    var shortFormHeight: PanModalHeight {
        .contentHeight(bounds.height * 0.66)
    }
    var longFormHeight: PanModalHeight {
        .contentHeight(bounds.height * 0.66)
    }
}

// MARK: - UserPresentable
extension UserViewController {
    var viewWillDisAppearTrigger: Observable<Void> {
        self.rx.viewWillDisAppear
            .asObservable()
    }
}

// MARK: - Method
private extension UserViewController {
    func setUpUser(user: GRIGAPI.GrigEntityQuery.Data.Ranking) {
        userProfileImageView.kf.setImage(with: URL(string: user.avatarUrl ?? "") ?? .none,
                                         placeholder: UIImage(),
                                         options: [])
        nameLabel.text = "\(user.name ?? "")(\(user.generation ?? 0)기)"
        nicknameLabel.text = user.nickname
        followStatView.setStatValue(value: user.following ?? 0)
        followerStatView.setStatValue(value: user.followers ?? 0)
        commitStatView.setStatValue(value: user.contributions ?? 0)
    }
}
