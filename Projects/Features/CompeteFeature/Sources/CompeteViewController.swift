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

protocol CompetePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class CompeteViewController: BaseViewController, CompetePresentable, CompeteViewControllable {
    // MARK: - Properties
    private let myProfileImageView = UIImageView().then {
        $0.layer.borderColor = CoreAsset.Colors.grigCompetePrimary.color.cgColor
        $0.layer.borderWidth = 6
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 44
    }
    private let myNameLabel = UILabel().then {
        $0.textColor = CoreAsset.Colors.grigSecondaryTextColor.color
        $0.font = .systemFont(ofSize: 16)
        $0.text = "asdf"
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
        $0.text = "찬우유"
    }
    private let commitChartView = CombinedChartView().then {
        $0.noDataText = "데이터가 없습니다."
        $0.layer.cornerRadius = 10
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

    weak var listener: CompetePresentableListener?
    
    override func addView() {
        view.addSubviews(myProfileImageView, myNameLabel, competeProfileImageView, competeNameLabel, commitChartView)
    }
    override func setLayout() {
        myProfileImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(45)
            $0.leading.equalToSuperview().offset(20)
            $0.size.equalTo(88)
        }
        myNameLabel.snp.makeConstraints {
            $0.centerX.equalTo(myProfileImageView)
            $0.top.equalTo(myProfileImageView.snp.bottom).offset(8)
        }
        competeProfileImageView.snp.makeConstraints {
            $0.top.equalTo(myProfileImageView)
            $0.trailing.equalToSuperview().inset(20)
            $0.size.equalTo(88)
        }
        competeNameLabel.snp.makeConstraints {
            $0.centerX.equalTo(competeProfileImageView)
            $0.top.equalTo(competeProfileImageView.snp.bottom).offset(8)
        }
        commitChartView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(myNameLabel.snp.bottom).offset(24)
            $0.height.equalTo(266)
        }
    }
    override func configureVC() {
        view.backgroundColor = CoreAsset.Colors.grigBackground.color
        let data = [
            "0511": 2,
            "0512": 12,
            "0513": 31,
            "0514": 21,
            "0515": 11,
            "0516": 23
        ].sorted(by: <)
        var lineEntry: [ChartDataEntry] = []
        data.enumerated().forEach { item in
            let line = ChartDataEntry(x: Double(item.offset), y: Double(item.element.value))
            lineEntry.append(line)
        }
        let lineDataSet = LineChartDataSet(entries: lineEntry, label: "asdf")
        lineDataSet.circleHoleRadius = 0.0
        lineDataSet.circleRadius = 3.5
        lineDataSet.lineWidth = 3
        lineDataSet.circleColors = [CoreAsset.Colors.grigCompetePrimary.color]
        lineDataSet.colors = [CoreAsset.Colors.grigCompetePrimary.color]
        lineDataSet.mode = .cubicBezier
        lineDataSet.lineDashPhase = 20
        let lineData = LineChartData(dataSet: lineDataSet)
        
        let combined = CombinedChartData()
        combined.lineData = lineData
        
        commitChartView.data = combined
    }
    override func configureNavigation() {
        self.navigationController?.title = "경쟁"
    }
    
    override func bindListener() {
        
    }
}

// MARK: - Method
private extension CompeteViewController {
    func setChart(
        
    ) {
        
    }
}
