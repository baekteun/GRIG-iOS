import UIKit
import Utility
import Then
import Core
import SnapKit

final class UserStatView: UIView {
    // MARK: - Properties
    private let valueLabel = UILabel().then {
        $0.textColor = .init(red: 0.1882, green: 0.6313, blue: 0.3058, alpha: 1)
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    private let statLabel = UILabel().then {
        $0.textColor = CoreAsset.Colors.girgGray.color
        $0.font = .systemFont(ofSize: 12, weight: .regular)
    }
    
    // MARK: - Init
    init(stat: UserStat, value: Int) {
        super.init(frame: .zero)
        statLabel.text = stat.display
        addView()
        setLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    public func setStatValue(value: Int) {
        valueLabel.text = "\(value)"
    }
}

private extension UserStatView {
    func addView() {
        addSubviews(valueLabel, statLabel)
    }
    func setLayout() {
        valueLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.snp.centerY)
        }
        statLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.snp.centerY)
        }
    }
    func configureView() {
        
    }
}
