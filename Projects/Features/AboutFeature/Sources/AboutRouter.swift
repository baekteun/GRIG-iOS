//
//  AboutRouter.swift
//  AboutFeature
//
//  Created by 최형우 on 2022/05/02.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RIBs

protocol AboutInteractable: Interactable {
    var router: AboutRouting? { get set }
    var listener: AboutListener? { get set }
}

protocol AboutViewControllable: ViewControllable {
    func presentMailScene()
}

final class AboutRouter: ViewableRouter<AboutInteractable, AboutViewControllable>, AboutRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: AboutInteractable, viewController: AboutViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func presentMailScene() {
        viewController.presentMailScene()
    }
}
