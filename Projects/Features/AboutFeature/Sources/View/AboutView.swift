import CDMarkdownKit
import UIKit
import Utility
import SnapKit
import Then
import Core

final class AboutView: UIView {
    // MARK: - Properties
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textColor = CoreAsset.Colors.grigPrimaryTextColor.color
    }
    private let descriptionTextView = UITextView().then {
        $0.isEditable = false
        $0.isSelectable = true
        $0.isUserInteractionEnabled = true
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
    }
    
    // MARK: - Init
    init(about: About) {
        super.init(frame: .zero)
        titleLabel.text = about.rawValue
        descriptionTextView.delegate = self
        descriptionTextView.attributedText = about.description
        addView()
        setLayout()
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AboutView {
    func addView() {
        addSubviews(titleLabel, descriptionTextView)
    }
    func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        descriptionTextView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        textViewDidChange(descriptionTextView)
    }
    func configureLabel() {
        
    }
}

extension AboutView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
        setNeedsLayout()
    }
}
