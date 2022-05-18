import UIKit
import ThirdPartyLib
import Then
import Core
import Utility
import SnapKit

final class CompeteView: UIView {
    // MARK: - Metric
    enum Metric {
        static let marginHorizontal = 16
    }
    
    // MARK: - Properties
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = CoreAsset.Colors.grigPrimaryTextColor.color
    }
    private let subTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = CoreAsset.Colors.grigSecondaryTextColor.color
    }
    private let myBarView = UIView().then {
        $0.backgroundColor = CoreAsset.Colors.grigCompetePrimary.color
        $0.layer.cornerRadius = 4
    }
    private let myValueLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = CoreAsset.Colors.grigWhite.color
    }
    private let competeBarView = UIView().then {
        $0.backgroundColor = CoreAsset.Colors.grigCompeteSecondary.color
        $0.layer.cornerRadius = 4
    }
    private let competeValueLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = CoreAsset.Colors.grigWhite.color
    }
    
    // MARK: - Init
    init(
        criteria: String
    ) {
        titleLabel.text = criteria
        subTitleLabel.text = "총 \(criteria) 비교"
        super.init(frame: .zero)
        addView()
        setLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    public func setValue(
        myValue: Int,
        competeValue: Int
    ) {
        let total: CGFloat = CGFloat(myValue) + CGFloat(competeValue)
        let myPer: CGFloat = CGFloat(myValue) / total
        let comPer: CGFloat = CGFloat(competeValue) / total
        let myWidth = (self.frame.width-34) * myPer
        let comWidth = (self.frame.width-34) * comPer
        UIView.animate(withDuration: 1) { [weak self] in
            self?.myBarView.snp.updateConstraints {
                $0.width.equalTo(myWidth)
            }
            self?.competeBarView.snp.updateConstraints {
                $0.width.equalTo(comWidth)
            }
            self?.layoutIfNeeded()
        }
        myValueLabel.text = "\(myValue)"
        competeValueLabel.text = "\(competeValue)"
    }
}

// MARK: - UI
private extension CompeteView {
    func addView() {
        addSubviews(titleLabel, subTitleLabel, myBarView, myValueLabel, competeBarView, competeValueLabel)
    }
    func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(Metric.marginHorizontal)
        }
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(1)
            $0.leading.equalToSuperview().offset(Metric.marginHorizontal)
        }
        myBarView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(Metric.marginHorizontal)
            $0.height.equalTo(24)
            $0.width.equalTo(0)
        }
        myValueLabel.snp.makeConstraints {
            $0.leading.equalTo(myBarView).offset(8)
            $0.centerY.equalTo(myBarView)
        }
        competeBarView.snp.makeConstraints {
            $0.top.equalTo(myBarView)
            $0.trailing.equalToSuperview().inset(Metric.marginHorizontal)
            $0.height.equalTo(24)
            $0.width.equalTo(0)
        }
        competeValueLabel.snp.makeConstraints {
            $0.trailing.equalTo(competeBarView).offset(-8)
            $0.centerY.equalTo(competeBarView)
        }
    }
    func configureView() {
        layer.cornerRadius = 10
        backgroundColor = CoreAsset.Colors.grigWhite.color
    }
}

