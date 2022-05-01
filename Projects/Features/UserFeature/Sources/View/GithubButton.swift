import UIKit
import SnapKit
import Utility
import Core

final class GithubButton: UIButton {
    // MARK: - Properties
    private let githubIconImage = UIImageView(image: CoreAsset.Images.grigGithubIcon.image)
    private let githubLabel = UILabel().then {
        $0.textColor = CoreAsset.Colors.grigPrimaryTextColor.color
        $0.font = .systemFont(ofSize: 16, weight: .regular)
    }
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        addView()
        setLayout()
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI
private extension GithubButton {
    func addView() {
        addSubviews(githubIconImage, githubLabel)
    }
    func setLayout() {
        githubIconImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.centerY.equalToSuperview()
        }
        githubLabel.snp.makeConstraints {
            $0.leading.equalTo(githubIconImage.snp.trailing).offset(15)
            $0.centerY.equalToSuperview()
        }
    }
    func configureButton() {
        backgroundColor = CoreAsset.Colors.grigWhite.color
        layer.cornerRadius = 8
        githubLabel.text = "Github"
    }
}
