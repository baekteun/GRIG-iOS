//
//  OnBoardingRouter.swift
//  OnBoardingFeature
//
//  Created by 최형우 on 2022/05/23.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RIBs

protocol OnBoardingInteractable: Interactable {
    var router: OnBoardingRouting? { get set }
    var listener: OnBoardingListener? { get set }
}

protocol OnBoardingViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class OnBoardingRouter: ViewableRouter<OnBoardingInteractable, OnBoardingViewControllable>, OnBoardingRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: OnBoardingInteractable, viewController: OnBoardingViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
