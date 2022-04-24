import CommonFeature
import Domain
import Utility
import Apollo
import SnapKit
import UIKit
import Then
import Reusable
import Kingfisher

final class RankTableCell: BaseTableViewCell<(Int, GRIGEntity)> {
    // MARK: - Properties
    private let rankLabel = UILabel()
    private let avatarImageView = UIImageView().then {
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
    }
    private let nicknameLabel = UILabel()
    private let generationLabel = UILabel()
    private let resultLabel = UILabel().then {
        $0.textAlignment = .center
    }
    private let bioLabel = UILabel().then {
        $0.numberOfLines = 0
    }
    // MARK: - UI
    override func addView() {
    }
    override func setLayout() {
    }
    override func configureCell() {
    }
    override func bind(_ model: (Int, GRIGEntity)) {
        rankLabel.text = "\(model.0)"
        let entity = model.1
        nicknameLabel.text = "\(entity.nickname)(\(entity.name))"
        avatarImageView.kf.setImage(with: URL(string: entity.avatarUrl),
                                    placeholder: UIImage(),
                                    options: [])
        generationLabel.text = "\(entity.generation)"
        bioLabel.text = entity.bio
        resultLabel.text = "\(entity.result)"
    }
}
