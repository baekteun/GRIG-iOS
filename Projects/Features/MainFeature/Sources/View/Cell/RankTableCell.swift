import CommonFeature
import Domain
import Utility
import Apollo
import SnapKit
import UIKit
import Then
import Reusable
import Kingfisher
import Core

final class RankTableCell: BaseTableViewCell<(Int, Criteria, GRIGAPI.GrigEntityQuery.Data.Ranking)> {
    // MARK: - Properties
    private let view = UIView().then {
        $0.backgroundColor = CoreAsset.Colors.grigWhite.color
        $0.layer.cornerRadius = 8
    }
    private let rankLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.textColor = CoreAsset.Colors.grigPrimaryTextColor.color
    }
    private let avatarImageView = UIImageView().then {
        $0.layer.cornerRadius = 22.5
        $0.clipsToBounds = true
    }
    private let nicknameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textColor = CoreAsset.Colors.grigPrimaryTextColor.color
    }
    private let nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textColor = CoreAsset.Colors.grigSecondaryTextColor.color
    }
    private let resultLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textColor = CoreAsset.Colors.grigPrimaryTextColor.color
        $0.textAlignment = .center
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        model = nil
    }
    
    // MARK: - UI
    override func addView() {
        contentView.addSubviews(view)
        view.addSubviews(rankLabel, avatarImageView, nameLabel, nicknameLabel, resultLabel)
    }
    override func setLayout() {
        view.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        rankLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
        }
        avatarImageView.snp.makeConstraints {
            $0.leading.equalTo(rankLabel.snp.leading).offset(35)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(45)
        }
        nicknameLabel.snp.makeConstraints {
            $0.leading.equalTo(avatarImageView.snp.trailing).offset(15)
            $0.trailing.greaterThanOrEqualTo(resultLabel.snp.leading)
            $0.bottom.equalTo(contentView.snp.centerY)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.centerY)
            $0.leading.equalTo(nicknameLabel)
        }
        resultLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalToSuperview()
        }
    }
    override func configureCell() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    override func bind(_ model: (Int, Criteria, GRIGAPI.GrigEntityQuery.Data.Ranking)) {
        rankLabel.text = "\(model.0)"
        let entity = model.2
        avatarImageView.kf.setImage(with: URL(string: entity.avatarUrl ?? ""),
                                    placeholder: UIImage(),
                                    options: [])
        nameLabel.text = entity.name
        nicknameLabel.text = "\(entity.nickname ?? "") (\(entity.generation ?? 0)기)"
        var res = 0
        switch model.1 {
        case .contributions:
            res = entity.contributions ?? 0
        case .stared:
            res = entity.stared ?? 0
        case .following:
            res = entity.following ?? 0
        case .follower:
            res = entity.followers ?? 0
        case .forked:
            res = entity.forked ?? 0
        case .issues:
            res = entity.issues ?? 0
        case .pullRequests:
            res = entity.pullRequests ?? 0
        }
        resultLabel.text = res.toDecimalString()
    }
}
