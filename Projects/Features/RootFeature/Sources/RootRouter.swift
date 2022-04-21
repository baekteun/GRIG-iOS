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

protocol RootInteractable: Interactable, MainListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    private let mainBuilder: MainBuildable
    
    init(
        mainBuilder: MainBuildable,
        interactor: RootInteractable,
        viewController: RootViewControllable
    ) {
        self.mainBuilder = mainBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        attachMain()
    }
}

private extension RootRouter {
    func attachMain() {
        let router = mainBuilder.build(withListener: interactor)
        attachChild(router)
        viewControllable.setViewControllers([router.viewControllable], animated: false)
    }
}
