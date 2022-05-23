//
//  OnboardingRouter.swift
//  OnboardingFeatureDemoApp
//
//  Created by 최형우 on 2022/05/23.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RIBs

protocol OnboardingInteractable: Interactable {
    var router: OnboardingRouting? { get set }
    var listener: OnboardingListener? { get set }
}

protocol OnboardingViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class OnboardingRouter: ViewableRouter<OnboardingInteractable, OnboardingViewControllable>, OnboardingRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: OnboardingInteractable, viewController: OnboardingViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
