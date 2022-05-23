//
//  OnboardingViewController.swift
//  OnboardingFeatureDemoApp
//
//  Created by 최형우 on 2022/05/23.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol OnboardingPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class OnboardingViewController: UIViewController, OnboardingPresentable, OnboardingViewControllable {

    weak var listener: OnboardingPresentableListener?
}
