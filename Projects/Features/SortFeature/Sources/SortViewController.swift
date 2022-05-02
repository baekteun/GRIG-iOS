//
//  SortViewController.swift
//  SortFeature
//
//  Created by 최형우 on 2022/05/01.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import CommonFeature
import Then
import SnapKit
import RxGesture
import Core
import ViewAnimator

protocol SortPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class SortViewController: BaseViewController, SortPresentable, SortViewControllable {
    // MARK: - Properties
    private let sortView = UIView().then {
        $0.backgroundColor = CoreAsset.Colors.grigWhite.color
        $0.layer.cornerRadius = 20
    }
    private let dimmedView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.45)
    }
    private let criteriaPicker = UIPickerView()
    private let generationPicker = UIPickerView()
    private let completeButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
    }
    private let titleLabel = UILabel().then {
        $0.text = "정렬 기준"
        $0.textColor = CoreAsset.Colors.grigPrimaryTextColor.color
        $0.font = .systemFont(ofSize: 16, weight: .regular)
    }
    
    weak var listener: SortPresentableListener?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(views: [
            sortView
        ], animations: [
            AnimationType.from(direction: .bottom, offset: 500)
        ], duration: 0.45)
    }
    
    // MARK: - UI
    override func addView() {
        view.addSubviews(dimmedView, sortView)
        sortView.addSubviews(titleLabel, completeButton, criteriaPicker, generationPicker)
    }
    override func setLayout() {
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        sortView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(295)
            $0.width.equalTo(312)
        }
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(16)
        }
        criteriaPicker.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.width.equalTo(211)
        }
        generationPicker.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.width.equalTo(101)
        }
        completeButton.snp.makeConstraints {
            $0.trailing.top.equalToSuperview().inset(17)
        }
    }
    override func configureVC() {
        view.backgroundColor = .clear
    }
}

extension SortViewController {
    var dimmedViewDidTap: Observable<Void> {
        self.dimmedView.rx.tapGesture().when(.recognized).map { _ in () }.asObservable()
    }
    var completeButtonDidTap: Observable<Void> {
        self.completeButton.rx.tap.asObservable()
    }
}
