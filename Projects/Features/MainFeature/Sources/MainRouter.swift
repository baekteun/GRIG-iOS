//
//  MainRouter.swift
//  MainFeatureTests
//
//  Created by 최형우 on 2022/04/21.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RIBs
import UserFeature
import Domain
import PanModal
import UIKit
import Utility

protocol MainInteractable: Interactable, UserListener {
    var router: MainRouting? { get set }
    var listener: MainListener? { get set }
}
protocol MainViewControllable: ViewControllable {
    func CustomPresent(_ viewController: ViewControllable)
}

final class MainRouter: ViewableRouter<MainInteractable, MainViewControllable>, MainRouting {
    
    private let userBuilder: UserBuildable
    private var userRouter: UserRouting?

    // TODO: Constructor inject child builder protocols to allow building children.
    init(
        interactor: MainInteractable,
        viewController: MainViewControllable,
        userBuilder: UserBuildable
    ) {
        self.userBuilder = userBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

 extension MainRouter {
    func attachUser(user: GRIGAPI.GrigEntityQuery.Data.Ranking) {
        let router = userBuilder.build(withListener: interactor, user: user)
        userRouter = router
        attachChild(router)
        viewControllable.presentPanModal(router.viewControllable)
    }
     func detachUser() {
         guard let router = userRouter else { return }
         viewController.dismiss(animated: true, completion: nil)
         detachChild(router)
         userRouter = nil
     }
     func attachSort(closure: ((Criteria, Int) -> Void)) {
         
     }
     func detachSort() {
         
     }
     func presentActionSheet() {
         viewControllable.presentAlert(title: "GRIG", message: "Github Rank In GSM", style: .actionSheet, actions: [
            .init(title: "Join", style: .default, handler: { [weak self] _ in
                
            }),
            .init(title: "Open API", style: .default, handler: { [weak self] _ in
                
            }),
            .init(title: "About", style: .default, handler: { [weak self] _ in
                
            }),
            .init(title: "Cancel", style: .cancel, handler: nil)
         ])
     }
}
