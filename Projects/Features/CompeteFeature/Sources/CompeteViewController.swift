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

protocol CompetePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class CompeteViewController: BaseViewController, CompetePresentable, CompeteViewControllable {
    // MARK: - Properties
    private let myProfileImageView = UIImageView().then {
        $0.layer.borderColor = UIColor(red: 0.949, green: 0.411, blue: 0.411, alpha: 1).cgColor
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 44
    }
    private let competeProfileImageView = UIImageView().then {
        $0.layer.borderColor = UIColor(red: 0.949, green: 0.411, blue: 0.411, alpha: 1).cgColor
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 44
    }

    weak var listener: CompetePresentableListener?
    
    override func addView() {
        view.addSubviews(myProfileImageView, competeProfileImageView)
    }
    override func setLayout() {
        myProfileImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(45)
            $0.leading.equalToSuperview().offset(20)
            $0.size.equalTo(88)
        }
        competeProfileImageView.snp.makeConstraints {
            $0.top.equalTo(myProfileImageView)
            $0.trailing.equalToSuperview().inset(20)
            $0.size.equalTo(88)
        }
    }
    override func configureVC() {
        view.backgroundColor = CoreAsset.Colors.grigBackground.color
    }
    override func configureNavigation() {
        self.navigationController?.title = "경쟁"
    }
}
