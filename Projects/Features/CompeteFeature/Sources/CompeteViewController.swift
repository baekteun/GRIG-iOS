//
//  CompeteViewController.swift
//  CompeteFeatureDemoApp
//
//  Created by 최형우 on 2022/05/16.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import CommonFeature
import Utility
import ThirdPartyLib
import SnapKit
import Core
import Charts
import Domain
import RxRelay

protocol CompetePresentableListener: AnyObject {
    var competeUser: PublishRelay<(GRIGAPI.GithubUserQuery.Data.User, GRIGAPI.GithubUserQuery.Data.User)> { get }
}

final class CompeteViewController: BaseViewController, CompetePresentable, CompeteViewControllable {
    // MARK: - Metric
    enum Metric {
        static let marginHorizontal = 20
    }
    // MARK: - Properties
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let myProfileImageView = UIImageView().then {
        $0.layer.borderColor = CoreAsset.Colors.grigCompetePrimary.color.cgColor
        $0.layer.borderWidth = 6
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 44
    }
    private let myNameLabel = UILabel().then {
        $0.textColor = CoreAsset.Colors.grigSecondaryTextColor.color
        $0.font = .systemFont(ofSize: 16)
        $0.text = ""
    }
    private let competeProfileImageView = UIImageView().then {
        $0.layer.borderColor = CoreAsset.Colors.grigCompeteSecondary.color.cgColor
        $0.layer.borderWidth = 6
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 44
    }
    private let competeNameLabel = UILabel().then {
        $0.textColor = CoreAsset.Colors.grigSecondaryTextColor.color
        $0.font = .systemFont(ofSize: 16)
        $0.text = ""
    }
    private let chartTitleView = UIView().then {
        $0.backgroundColor = CoreAsset.Colors.grigWhite.color
        $0.layer.cornerRadius = 10
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    private let chartTitleLabel = UILabel().then {
        $0.text = "5일 커밋 수"
        $0.font = .systemFont(ofSize: 18)
        $0.textColor = CoreAsset.Colors.grigPrimaryTextColor.color
    }
    private let chartSubTitleLabel = UILabel().then {
        $0.text = "커밋 비교 그래프"
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = CoreAsset.Colors.grigSecondaryTextColor.color
    }
    private let commitChartView = CombinedChartView().then {
        $0.noDataText = "데이터가 없습니다."
        $0.layer.cornerRadius = 10
        $0.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        $0.clipsToBounds = true
        $0.backgroundColor = CoreAsset.Colors.grigWhite.color
        $0.xAxis.labelPosition = .bottom
        $0.xAxis.gridColor = .clear
        $0.rightAxis.axisLineColor = .clear
        $0.rightAxis.labelTextColor = .clear
        $0.rightAxis.gridLineDashLengths = [5]
        $0.leftAxis.axisLineColor = .clear
        $0.leftAxis.gridLineDashLengths = [5]
    }
    private let competeStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 16
    }
    private let commitCompeteView = CompeteView(criteria: "커밋")
    private let followerCompeteView = CompeteView(criteria: "팔로워")
    private let followCompeteView = CompeteView(criteria: "팔로우")
    private let prCompeteView = CompeteView(criteria: "PR")
    private let issueCompeteView = CompeteView(criteria: "이슈")

    weak var listener: CompetePresentableListener?
    
    // MARK: - UI
    override func addView() {
        competeStackView.addArrangeSubviews(commitCompeteView, followerCompeteView, followCompeteView, prCompeteView, issueCompeteView)
        view.addSubviews(scrollView)
        scrollView.addSubviews(contentView)
        chartTitleView.addSubviews(chartTitleLabel, chartSubTitleLabel)
        contentView.addSubviews(myProfileImageView, myNameLabel, chartTitleView, competeProfileImageView, competeNameLabel, commitChartView, competeStackView)
    }
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
        }
        myProfileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(45)
            $0.leading.equalToSuperview().offset(Metric.marginHorizontal)
            $0.size.equalTo(88)
        }
        myNameLabel.snp.makeConstraints {
            $0.centerX.equalTo(myProfileImageView)
            $0.top.equalTo(myProfileImageView.snp.bottom).offset(8)
        }
        competeProfileImageView.snp.makeConstraints {
            $0.top.equalTo(myProfileImageView)
            $0.trailing.equalToSuperview().inset(Metric.marginHorizontal)
            $0.size.equalTo(88)
        }
        competeNameLabel.snp.makeConstraints {
            $0.centerX.equalTo(competeProfileImageView)
            $0.top.equalTo(competeProfileImageView.snp.bottom).offset(8)
        }
        chartTitleView.snp.makeConstraints {
            $0.top.equalTo(myNameLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(Metric.marginHorizontal)
            $0.height.equalTo(68)
        }
        chartTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
        }
        chartSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(chartTitleLabel.snp.bottom).offset(1)
            $0.leading.equalToSuperview().offset(16)
        }
        commitChartView.snp.makeConstraints {
            $0.top.equalTo(chartTitleView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(Metric.marginHorizontal)
            $0.height.equalTo(198)
        }
        [commitCompeteView, followerCompeteView, followCompeteView, prCompeteView, issueCompeteView].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(100)
            }
        }
        competeStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Metric.marginHorizontal)
            $0.top.equalTo(commitChartView.snp.bottom).offset(16)
            $0.bottom.equalToSuperview().offset(-12)
        }
    }
    override func configureVC() {
        view.backgroundColor = CoreAsset.Colors.grigBackground.color
    }
    override func configureNavigation() {
        self.navigationController?.title = "경쟁"
    }
    
    override func bindListener() {
        
    }
}

extension CompeteViewController {
    var viewWillDisAppearTrigger: Observable<Void> {
        self.rx.viewWillDisAppear.asObservable()
    }
    var viewWillAppearTrigger: Observable<Void> {
        self.rx.viewWillAppear.asObservable()
    }
}

// MARK: - Method
private extension CompeteViewController {
    func setChart(
        my: GRIGAPI.GithubUserQuery.Data.User,
        compete: GRIGAPI.GithubUserQuery.Data.User
    ) {
        let myData = my.contributionsCollection.contributionCalendar.weeks
        var myLineEntry = [ChartDataEntry]()
        myData.forEach { item in
            item.contributionDays.enumerated().forEach { item in
                myLineEntry.append(
                    .init(
                        x: Double(item.offset),
                        y: Double(item.element.contributionCount)
                    )
                )
            }
        }
        
        let competeData = my.contributionsCollection.contributionCalendar.weeks
        var competeLineEntry = [ChartDataEntry]()
        competeData.forEach { item in
            item.contributionDays.enumerated().forEach { item in
                competeLineEntry.append(
                    .init(
                        x: Double(item.offset),
                        y: Double(item.element.contributionCount)
                    )
                )
            }
        }
        
        let myLineDataSet = LineChartDataSet(entries: myLineEntry, label: my.login)
        myLineDataSet.customConfig(color: CoreAsset.Colors.grigCompetePrimary.color)
        let competeLineDataSet = LineChartDataSet(entries: competeLineEntry, label: compete.login)
        competeLineDataSet.customConfig(color: CoreAsset.Colors.grigCompeteSecondary.color)
        
        let combinedData = CombinedChartData(dataSets: [myLineDataSet, competeLineDataSet])
        
        commitChartView.data = combinedData
    }
}

private extension LineChartDataSet {
    func customConfig(color: UIColor) {
        self.circleHoleRadius = 0.0
        self.circleRadius = 3.5
        self.lineWidth = 3
        self.circleColors = [color]
        self.colors = [color]
        self.mode = .cubicBezier
        self.lineDashPhase = 20
    }
}
