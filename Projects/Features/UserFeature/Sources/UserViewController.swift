//
//  UserViewController.swift
//  UserFeature
//
//  Created by 최형우 on 2022/04/27.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import PanModal

protocol UserPresentableListener: AnyObject {
    
}

final class UserViewController: UIViewController, UserPresentable, UserViewControllable {
    // MARK: - Properties
    private let userProfileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let nicknameLabel = UILabel()
    
    
    weak var listener: UserPresentableListener?
    
    
    
}

extension UserViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        nil
    }
    var shortFormHeight: PanModalHeight {
        .contentHeight(UIScreen.main.bounds.height * 0.66)
    }
}
