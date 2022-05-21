//
//  CompeteRouter.swift
//  CompeteFeatureDemoApp
//
//  Created by 최형우 on 2022/05/16.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RIBs
import UIKit

protocol CompeteInteractable: Interactable {
    var router: CompeteRouting? { get set }
    var listener: CompeteListener? { get set }
}

protocol CompeteViewControllable: ViewControllable {
    func presentAlertWithTextField(
        title: String?,
        message: String?,
        initialFirstTFValue: String?,
        initialSecondTFValue: String?,
        completion: @escaping ((String, String) -> Void)
    )
    func presentShare(image: UIImage)
}

final class CompeteRouter: ViewableRouter<CompeteInteractable, CompeteViewControllable>, CompeteRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: CompeteInteractable, viewController: CompeteViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func presentAlertWithTextField(
       title: String?,
       message: String?,
       initialFirstTFValue: String?,
       initialSecondTFValue: String?,
       completion: @escaping ((String, String) -> Void)
    ) {
        viewController.presentAlertWithTextField(
           title: title,
           message: message,
           initialFirstTFValue: initialFirstTFValue,
           initialSecondTFValue: initialSecondTFValue,
           completion: completion
        )
    }
    func presentShare(image: UIImage) {
        viewController.presentShare(image: image)
    }
}
