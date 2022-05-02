import CDMarkdownKit
import UIKit
import Utility
import SnapKit
import Then

final class AboutLabel: UIView {
    // MARK: - Properties
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .white
    }
    private let descriptionLabel = UILabel()
    
    // MARK: - Init
    init(about: About) {
        super.init(frame: .zero)
        titleLabel.text = about.rawValue
        descriptionLabel.attributedText = about.description
        addView()
        setLayout()
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AboutLabel {
    func addView() {
        addSubviews(titleLabel, descriptionLabel)
    }
    func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    func configureLabel() {
        
    }
}
