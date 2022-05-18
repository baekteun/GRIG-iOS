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
import RxRelay
import Utility
import Domain

protocol SortPresentableListener: AnyObject {
    var criteriaList: BehaviorRelay<[Criteria]> { get }
    var generationList: BehaviorRelay<[GRIGAPI.GrigGenerationQuery.Data.Generation?]> { get }
    var isLoading: BehaviorRelay<Bool> { get }
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
        completeButton.snp.makeConstraints {
            $0.trailing.top.equalToSuperview().inset(17)
        }
        criteriaPicker.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.width.equalTo(211)
        }
        generationPicker.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.width.equalTo(101)
        }
    }
    override func configureVC() {
        view.backgroundColor = .clear
    }
    
    override func bindListener() {
        listener?.criteriaList
            .bind(to: criteriaPicker.rx.itemTitles) { _, item in
                return item.rawValue
            }
            .disposed(by: disposeBag)
        
        listener?.generationList
            .map { $0.compactMap { $0 } }
            .bind(to: generationPicker.rx.itemTitles) { _, item in
                
                if item._id == 0 {
                    return "All"
                } else {
                    return "\(item._id ?? 1)기"
                }
            }
            .disposed(by: disposeBag)
        
        listener?.isLoading
            .bind(with: self, onNext: { owner, isLoading in
                isLoading ? owner.startIndicator() : owner.stopIndicator()
            })
            .disposed(by: disposeBag)
    }
}

extension SortViewController {
    var dimmedViewDidTap: Observable<Void> {
        self.dimmedView.rx.tapGesture().when(.recognized).map { _ in () }.asObservable()
    }
    var completeButtonDidTap: Observable<Void> {
        self.completeButton.rx.tap.asObservable()
    }
    var criteriaDidChange: Observable<Int> {
        self.criteriaPicker.rx.itemSelected.asObservable().map(\.row)
    }
    var generationDidChange: Observable<Int> {
        self.generationPicker.rx.itemSelected.asObservable().map(\.row)
    }
}
