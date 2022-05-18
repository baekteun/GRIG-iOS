import UIKit
import SnapKit
import Utility
import Core

final class UserCustomButton: UIButton {
    // MARK: - Properties
    private let iconImage = UIImageView()
    private let customTitleLabel = UILabel().then {
        $0.textColor = CoreAsset.Colors.grigPrimaryTextColor.color
        $0.font = .systemFont(ofSize: 16, weight: .regular)
    }
    private let rightChevronImage = UIImageView(image: .init(systemName: "chevron.right")?.tintColor(CoreAsset.Colors.grigPrimaryTextColor.color))
    
    // MARK: - Init
    init(
        icon: UIImage,
        title: String
    ) {
        super.init(frame: .zero)
        iconImage.image = icon
        customTitleLabel.text = title
        addView()
        setLayout()
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI
private extension UserCustomButton {
    func addView() {
        addSubviews(iconImage, customTitleLabel, rightChevronImage)
    }
    func setLayout() {
        iconImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.centerY.equalToSuperview()
        }
        customTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImage.snp.trailing).offset(15)
            $0.centerY.equalToSuperview()
        }
        rightChevronImage.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-24)
            $0.centerY.equalToSuperview()
        }
    }
    func configureButton() {
        backgroundColor = CoreAsset.Colors.grigWhite.color
        layer.cornerRadius = 8
    }
}
