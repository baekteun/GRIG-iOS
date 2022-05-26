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
import RxKeyboard

protocol CompetePresentableListener: AnyObject {
    var competeUser: PublishRelay<(GRIGAPI.GithubUserQuery.Data.User?, GRIGAPI.GithubUserQuery.Data.User?)> { get }
    var totalContributions: PublishRelay<(Int?, Int?)> { get }
    var isLoading: BehaviorRelay<Bool> { get }
    var userIDs: PublishRelay<(String?, String?)> { get }
}

final class CompeteViewController: BaseViewController, CompetePresentable, CompeteViewControllable {
    // MARK: - Metric
    enum Metric {
        static let marginHorizontal = 20
    }
    // MARK: - Properties
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let idView = UIView()
    private let myProfileImageView = UIImageView().then {
        $0.layer.borderColor = CoreAsset.Colors.grigCompetePrimary.color.cgColor
        $0.layer.borderWidth = 6
        $0.backgroundColor = .lightGray
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
        $0.backgroundColor = .lightGray
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
    
    private let notFoundImageView = UIImageView(image: CoreAsset.Images.grigSword.image.withRenderingMode(.alwaysOriginal)).then {
        $0.isHidden = true
    }
    private let notFoundDescriptionLabel = UILabel().then {
        $0.text = """
경쟁 분석표를 보기 위해서는
Github ID를 입력해야 합니다.
"""
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 17)
        $0.textColor = CoreAsset.Colors.grigPrimaryTextColor.color
        $0.isHidden = true
    }
    private let myUserIDTextField = UITextField().then {
        $0.font = .systemFont(ofSize: 17)
        $0.textColor = CoreAsset.Colors.grigPrimaryTextColor.color
        $0.placeholder = "My Github ID"
        $0.layer.cornerRadius = 6
        $0.setUnderLine(color: .lightGray)
        $0.leftSpace(16)
        $0.isHidden = true
    }
    private let competeUserIDTextField = UITextField().then {
        $0.font = .systemFont(ofSize: 17)
        $0.textColor = CoreAsset.Colors.grigPrimaryTextColor.color
        $0.placeholder = "Somone Github ID"
        $0.layer.cornerRadius = 6
        $0.setUnderLine(color: .lightGray)
        $0.leftSpace(16)
        $0.isHidden = true
    }
    private let completeButton = UIButton().then {
        $0.backgroundColor = CoreAsset.Colors.grigCompetePrimary.color
        $0.layer.cornerRadius = 6
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(CoreAsset.Colors.grigWhite.color, for: .normal)
        $0.isHidden = true
    }

    weak var listener: CompetePresentableListener?
    
    private let viewDidTransitionRelay = PublishRelay<Void>()
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { [weak self] _ in
            self?.viewDidTransitionRelay.accept(())
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      super.touchesEnded(touches, with: event)
      self.view.endEditing(true)
    }
    
    // MARK: - UI
    override func addView() {
        competeStackView.addArrangeSubviews(commitCompeteView, followerCompeteView, followCompeteView, prCompeteView, issueCompeteView)
        view.addSubviews(scrollView, idView)
        idView.addSubviews(notFoundImageView, notFoundDescriptionLabel, myUserIDTextField, competeUserIDTextField, completeButton)
        scrollView.addSubviews(contentView)
        chartTitleView.addSubviews(chartTitleLabel, chartSubTitleLabel)
        commitView.addSubviews(commitChartView)
        contentView.addSubviews(myProfileImageView, myNameLabel, chartTitleView, competeProfileImageView, competeNameLabel, commitView, competeStackView)
    }
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        idView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
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
        
        notFoundImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(view.safeAreaInsets.top + 60)
            $0.centerX.equalToSuperview()
        }
        notFoundDescriptionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(notFoundImageView.snp.bottom).offset(24)
        }
        completeButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-60)
            $0.height.equalTo(48)
        }
        competeUserIDTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(completeButton.snp.top).offset(-48)
            $0.height.equalTo(44)
        }
        myUserIDTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(competeUserIDTextField.snp.top).offset(-16)
            $0.height.equalTo(44)
        }
    }
    override func configureVC() {
        view.backgroundColor = CoreAsset.Colors.grigBackground.color
        if traitCollection.userInterfaceStyle == .dark {
            myUserIDTextField.backgroundColor = .darkGray
            competeUserIDTextField.backgroundColor = .darkGray
        }
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
                guard
                    let my = commit.0,
                    let compete = commit.1
                else {
                    owner.commitCompeteView.setValue(myValue: 1, competeValue: 1)
                    return
                }
                owner.commitCompeteView.setValue(myValue: my, competeValue: compete)
            })
            .disposed(by: disposeBag)
        
        listener?.competeUser
            .asObservable()
            .bind(with: self, onNext: { owner, user in
                guard
                    let my = user.0,
                    let compete = user.1
                else {
                    owner.showInvalidUsername()
                    return
                }
                owner.hideInvalidUsername()
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
        
        listener?.userIDs
            .bind(with: self, onNext: { owner, ids in
                owner.myUserIDTextField.text = ids.0
                owner.competeUserIDTextField.text = ids.1
            })
            .disposed(by: disposeBag)
        
        RxKeyboard.instance.visibleHeight
            .filter { [weak self] _ in
                self?.presentedViewController == nil
            }
            .asObservable()
            .bind(with: self) { owner, height in
                UIView.animate(withDuration: 0) {
                    owner.idView.snp.updateConstraints {
                        $0.bottom.equalToSuperview().offset(-height)
                    }
                    owner.notFoundImageView.snp.updateConstraints {
                        $0.top.equalToSuperview().offset((owner.view.safeAreaInsets.top) - height)
                    }
                    owner.view.layoutIfNeeded()
                }
            }
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
        self.topViewControllable.uiviewController.present(alert, animated: true, completion: nil)
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
            .debounce(.milliseconds(200), scheduler: MainScheduler.asyncInstance)
            .asObservable()
    }
    var viewDidTransitionTrigger: Observable<Void> {
        self.viewDidTransitionRelay.asObservable()
    }
    var shareButtonDidTap: Observable<UIImage> {
        self.shareButton.rx.tap
            .debounce(.microseconds(200), scheduler: MainScheduler.asyncInstance)
            .withUnretained(self)
            .delay(.milliseconds(2), scheduler: MainScheduler.asyncInstance)
            .compactMap { $0.0.navigationController?.view.asImage() }
            .asObservable()
    }
    var completeButtonDidTap: Observable<(String, String)> {
        self.completeButton.rx.tap
            .debounce(.milliseconds(200), scheduler: MainScheduler.asyncInstance)
            .withUnretained(self)
            .map { ($0.0.myUserIDTextField.text ?? "", $0.0.competeUserIDTextField.text ?? "") }
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
    func showInvalidUsername() {
        contentView.subviews.forEach {
            $0.isHidden = true
        }
        idView.subviews.forEach {
            $0.isHidden = false
        }
        idView.isHidden = false
    }
    func hideInvalidUsername() {
        contentView.subviews.forEach {
            $0.isHidden = false
        }
        idView.subviews.forEach {
            $0.isHidden = true
        }
        idView.isHidden = true
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
