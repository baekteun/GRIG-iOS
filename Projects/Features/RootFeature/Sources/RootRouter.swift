//
//  RootRouter.swift
//  RootFeature
//
//  Created by 최형우 on 2022/04/20.
//  Copyright © 2022 baegteun. All rights reserved.
//
import ThirdPartyLib
import RIBs
import MainFeature
import Network
import Loaf
import Core
import OnboardingFeature
import UIKit

protocol RootInteractable: Interactable, MainListener, OnboardingListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    private let mainBuilder: MainBuildable
    private var mainRouter: MainRouting?
    
    private let onboardingBuilder: OnboardingBuildable
    private var onboardingRouter: OnboardingRouting?
    
    init(
        mainBuilder: MainBuildable,
        onboardingBuilder: OnboardingBuildable,
        interactor: RootInteractable,
        viewController: RootViewControllable
    ) {
        self.mainBuilder = mainBuilder
        self.onboardingBuilder = onboardingBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

extension RootRouter {
    func attachMain() {
        let router = mainBuilder.build(withListener: interactor)
        attachChild(router)
        mainRouter = router
        let vc = UINavigationController(rootViewController: router.viewControllable.uiviewController)
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        viewControllable.uiviewController.present(vc, animated: true, completion: nil)
    }
    func attachOnboarding() {
        let router = onboardingBuilder.build(withListener: interactor)
        attachChild(router)
        onboardingRouter = router
        let vc = UINavigationController(rootViewController: router.viewControllable.uiviewController)
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        viewControllable.uiviewController.present(vc, animated: true, completion: nil)
    }
    func detachMain() {
        guard let router = mainRouter else { return }
        viewController.dismiss(animated: false, completion: nil)
        detachChild(router)
        mainRouter = nil
    }
    func detachOnboarding() {
        guard let router = onboardingRouter else { return }
        viewController.dismiss(animated: false, completion: nil)
        detachChild(router)
        onboardingRouter = nil
    }
}
