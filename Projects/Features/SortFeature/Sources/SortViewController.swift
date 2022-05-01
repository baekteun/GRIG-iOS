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

protocol SortPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class SortViewController: BaseViewController, SortPresentable, SortViewControllable {
    // MARK: - Properties
    private let sortView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
    }
    private let criteriaPicker = UIPickerView()
    private let generationPicker = UIPickerView()
    private let completeButton = UIButton()
    
    weak var listener: SortPresentableListener?
    
    // MARK: - UI
    override func addView() {
        view.addSubviews(sortView)
        sortView.addSubviews(criteriaPicker, generationPicker, completeButton)
    }
    override func setLayout() {
        sortView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(295)
            $0.width.equalTo(312)
        }
    }
    override func configureVC() {
        view.backgroundColor = .white.withAlphaComponent(0.25)
    }
}
