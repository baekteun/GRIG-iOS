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

protocol SortPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class SortViewController: UIViewController, SortPresentable, SortViewControllable {

    weak var listener: SortPresentableListener?
}
