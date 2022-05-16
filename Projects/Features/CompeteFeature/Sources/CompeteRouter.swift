//
//  CompeteRouter.swift
//  CompeteFeatureDemoApp
//
//  Created by 최형우 on 2022/05/16.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RIBs

protocol CompeteInteractable: Interactable {
    var router: CompeteRouting? { get set }
    var listener: CompeteListener? { get set }
}

protocol CompeteViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class CompeteRouter: ViewableRouter<CompeteInteractable, CompeteViewControllable>, CompeteRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: CompeteInteractable, viewController: CompeteViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
