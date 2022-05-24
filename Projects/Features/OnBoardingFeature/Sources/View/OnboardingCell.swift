import CommonFeature
import Utility
import UIKit

final class OnboardingCell: BaseCollectionViewCell<UIImage> {
    // MARK: - Properties
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    // MARK: - UI
    override func addView() {
        contentView.addSubviews(imageView)
    }
    override func setLayout() {
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(70)
            $0.width.equalTo(bounds.width - 32)
            $0.height.equalTo(bounds.height * 0.65)
        }
    }
    
    override func bind(_ model: UIImage) {
        imageView.image = model
    }
}
