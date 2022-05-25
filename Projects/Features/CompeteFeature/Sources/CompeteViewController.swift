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
import Kingfisher

protocol CompetePresentableListener: AnyObject {
    var competeUser: PublishRelay<(GRIGAPI.GithubUserQuery.Data.User, GRIGAPI.GithubUserQuery.Data.User)> { get }
    var totalContributions: PublishRelay<(Int, Int)> { get }
    var isLoading: BehaviorRelay<Bool> { get }
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
        $0.clipsToBounds = true
        $0.layer.masksToBounds = true
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
        $0.clipsToBounds = true
        $0.layer.masksToBounds = true
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
    private let commitView = UIView().then {
        $0.backgroundColor = CoreAsset.Colors.grigWhite.color
        $0.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    private let commitChartView = LineChartView().then {
        $0.noDataText = "데이터가 없습니다."
        $0.xAxis.labelPosition = .bottom
        $0.xAxis.gridColor = .clear
        $0.rightAxis.axisLineColor = .clear
        $0.rightAxis.labelTextColor = .clear
        $0.rightAxis.gridLineDashLengths = [5]
        $0.leftAxis.axisLineColor = .clear
        $0.leftAxis.gridLineDashLengths = [5]
        $0.highlightPerTapEnabled = false
        $0.highlightPerDragEnabled = false
        $0.pinchZoomEnabled = false
        $0.doubleTapToZoomEnabled = false
        $0.legend.enabled = false
        $0.xAxis.drawLabelsEnabled = false
        $0.leftAxis.labelTextColor = CoreAsset.Colors.grigSecondaryTextColor.color
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
    private let changeIDButton = UIBarButtonItem(
        image: .init(systemName: "highlighter")?.tintColor(CoreAsset.Colors.grigBlack.color),
        style: .plain,
        target: nil,
        action: nil
    )
    private let shareButton = UIBarButtonItem(image: .init(systemName: "square.and.arrow.up")?.tintColor(CoreAsset.Colors.grigBlack.color), style: .plain, target: nil, action: nil)

    weak var listener: CompetePresentableListener?
    
    private let viewDidTransitionRelay = PublishRelay<Void>()
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { [weak self] _ in
            self?.viewDidTransitionRelay.accept(())
        }
    }
    
    
    // MARK: - UI
    override func addView() {
        competeStackView.addArrangeSubviews(commitCompeteView, followerCompeteView, followCompeteView, prCompeteView, issueCompeteView)
        view.addSubviews(scrollView)
        scrollView.addSubviews(contentView)
        chartTitleView.addSubviews(chartTitleLabel, chartSubTitleLabel)
        commitView.addSubviews(commitChartView)
        contentView.addSubviews(myProfileImageView, myNameLabel, chartTitleView, competeProfileImageView, competeNameLabel, commitView, competeStackView)
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
        commitView.snp.makeConstraints {
            $0.top.equalTo(chartTitleView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(Metric.marginHorizontal)
            $0.height.equalTo(198)
        }
        commitChartView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(10)
            $0.top.equalToSuperview()
        }
        [commitCompeteView, followerCompeteView, followCompeteView, prCompeteView, issueCompeteView].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(100)
            }
        }
        competeStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Metric.marginHorizontal)
            $0.top.equalTo(commitView.snp.bottom).offset(16)
            $0.bottom.equalToSuperview().offset(-12)
        }
    }
    override func configureVC() {
        view.backgroundColor = CoreAsset.Colors.grigBackground.color
    }
    override func configureNavigation() {
        self.navigationItem.title = "경쟁"
        self.navigationController?.navigationBar.tintColor = CoreAsset.Colors.grigBlack.color
        self.navigationItem.setRightBarButtonItems([changeIDButton, shareButton], animated: true)
    }
    
    override func bindListener() {
        listener?.isLoading
            .bind(with: self, onNext: { owner, isLoading in
                isLoading ? owner.startIndicator() : owner.stopIndicator()
            })
            .disposed(by: disposeBag)
        
        listener?.totalContributions
            .asObservable()
            .bind(with: self, onNext: { owner, commit in
                let my = commit.0
                let compete = commit.1
                owner.commitCompeteView.setValue(myValue: my, competeValue: compete)
            })
            .disposed(by: disposeBag)
        
        listener?.competeUser
            .asObservable()
            .bind(with: self, onNext: { owner, user in
                let my = user.0
                let compete = user.1
                owner.myProfileImageView.kf.setImage(with: URL(string: my.avatarUrl) ?? .none)
                owner.myNameLabel.text = my.login
                owner.competeProfileImageView.kf.setImage(with: URL(string: compete.avatarUrl) ?? .none)
                owner.competeNameLabel.text = compete.login
                owner.setChart(my: my, compete: compete)
                owner.followerCompeteView.setValue(
                    myValue: my.followers.totalCount,
                    competeValue: compete.followers.totalCount
                )
                owner.followCompeteView.setValue(
                    myValue: my.following.totalCount,
                    competeValue: compete.following.totalCount
                )
                owner.prCompeteView.setValue(
                    myValue: my.pullRequests.totalCount,
                    competeValue: compete.pullRequests.totalCount
                )
                owner.issueCompeteView.setValue(
                    myValue: my.issues.totalCount,
                    competeValue: compete.issues.totalCount
                )
            })
            .disposed(by: disposeBag)
    }
    
    func presentAlertWithTextField(
        title: String?,
        message: String?,
        initialFirstTFValue: String?,
        initialSecondTFValue: String?,
        completion: @escaping ((String, String) -> Void)
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField()
        alert.addTextField()
        alert.textFields?[0].placeholder = "My Github ID"
        alert.textFields?[0].text = initialFirstTFValue
        alert.textFields?[1].placeholder = "Someone Github ID"
        alert.textFields?[1].text = initialSecondTFValue
        alert.addAction(.init(title: "취소", style: .cancel))
        alert.addAction(.init(title: "저장", style: .default, handler: { _ in
            completion(
                alert.textFields?[0].text ?? "",
                alert.textFields?[1].text ?? ""
            )
        }))
        self.uiviewController.present(alert, animated: true, completion: nil)
    }
    func presentShare(image: UIImage) {
        let items: [Any] = [image]
        let vc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        vc.popoverPresentationController?.sourceView = view
        vc.popoverPresentationController?.barButtonItem = shareButton
        self.topViewControllable.uiviewController.present(vc, animated: true, completion: nil)
    }
}

extension CompeteViewController {
    var viewDidDisAppearTrigger: Observable<Void> {
        self.rx.viewDidDisAppear.asObservable()
    }
    var viewDidAppearTrigger: Observable<Void> {
        self.rx.viewDidAppear.asObservable()
    }
    var changeIDButtonDidTap: Observable<Void> {
        self.changeIDButton.rx.tap
            .debounce(.microseconds(200), scheduler: MainScheduler.asyncInstance)
            .asObservable()
    }
    var viewDidTransitionTrigger: Observable<Void> {
        self.viewDidTransitionRelay.asObservable()
    }
    var shareButtonDidTap: Observable<UIImage> {
        self.shareButton.rx.tap
            .withUnretained(self)
            .delay(.milliseconds(2), scheduler: MainScheduler.asyncInstance)
            .compactMap { $0.0.navigationController?.view.asImage() }
            .asObservable()
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
        myData.forEach {
            $0.contributionDays.forEach { item in
                myLineEntry.append(
                    .init(
                        x: Double(myLineEntry.count),
                        y: Double(item.contributionCount)
                    )
                )
            }
        }
        
        let competeData = compete.contributionsCollection.contributionCalendar.weeks
        var competeLineEntry = [ChartDataEntry]()
        competeData.forEach {
            $0.contributionDays.forEach { item in
                competeLineEntry.append(
                    .init(
                        x: Double(competeLineEntry.count),
                        y: Double(item.contributionCount)
                    )
                )
            }
        }
        
        let myLineDataSet = LineChartDataSet(entries: myLineEntry, label: my.login)
        myLineDataSet.customConfig(color: CoreAsset.Colors.grigCompetePrimary.color)
        myLineDataSet.drawValuesEnabled = false
        let competeLineDataSet = LineChartDataSet(entries: competeLineEntry, label: compete.login)
        competeLineDataSet.customConfig(color: CoreAsset.Colors.grigCompeteSecondary.color)
        competeLineDataSet.drawValuesEnabled = false
        
        let lineData = LineChartData(dataSets: [myLineDataSet, competeLineDataSet])
        
        commitChartView.data = lineData
        commitChartView.animate(yAxisDuration: 1, easingOption: .linear)
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
