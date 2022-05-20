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
import SortFeature
import AboutFeature
import CompeteFeature

protocol MainInteractable: Interactable, UserListener, SortListener, AboutListener, CompeteListener {
    var router: MainRouting? { get set }
    var listener: MainListener? { get set }
}
protocol MainViewControllable: ViewControllable {
    func CustomPresent(_ viewController: ViewControllable)
    func presentAlertWithTextField(
        title: String?,
        message: String?,
        initialFirstTFValue: String?,
        initialSecondTFValue: String?,
        completion: @escaping ((String, String) -> Void)
    )
}

final class MainRouter: ViewableRouter<MainInteractable, MainViewControllable>, MainRouting {
    
    private let userBuilder: UserBuildable
    private var userRouter: UserRouting?
    
    private let sortBuilder: SortBuildable
    private var sortRouter: SortRouting?
    
    private let aboutBuilder: AboutBuildable
    private var aboutRouter: AboutRouting?
    
    private let competeBuilder: CompeteBuildable
    private var competeRouter: CompeteRouting?

    // TODO: Constructor inject child builder protocols to allow building children.
    init(
        interactor: MainInteractable,
        viewController: MainViewControllable,
        userBuilder: UserBuildable,
        sortBuilder: SortBuildable,
        aboutBuilder: AboutBuildable,
        competeBuilder: CompeteBuildable
    ) {
        self.userBuilder = userBuilder
        self.sortBuilder = sortBuilder
        self.aboutBuilder = aboutBuilder
        self.competeBuilder = competeBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

 extension MainRouter {
    func attachUser(user: GRIGAPI.GrigEntityQuery.Data.Ranking) {
        let router = userBuilder.build(withListener: interactor, user: user)
        userRouter = router
        attachChild(router)
        if UIDevice.current.userInterfaceIdiom == .pad {
            viewControllable.present(router.viewControllable, animated: true, completion: nil)
        } else {
            viewControllable.presentPanModal(router.viewControllable)
        }
    }
     func detachUser() {
         guard let router = userRouter else { return }
         viewController.dismiss(animated: true, completion: nil)
         detachChild(router)
         userRouter = nil
     }
     func attachSort(closure: @escaping ((Criteria, Int) -> Void)) {
         let router = sortBuilder.build(withListener: interactor, closure: closure)
         sortRouter = router
         attachChild(router)
         viewController.CustomPresent(router.viewControllable)
     }
     func detachSort() {
         guard let router = sortRouter else { return }
         viewController.dismiss(animated: true, completion: nil)
         detachChild(router)
         sortRouter = nil
     }
     func attachAbout() {
         let router = aboutBuilder.build(withListener: interactor)
         aboutRouter = router
         attachChild(router)
         viewController.pushViewController(router.viewControllable, animated: true)
     }
     func detachAbout() {
         guard let router = aboutRouter else { return }
         viewController.popViewController(animated: true)
         detachChild(router)
         aboutRouter = nil
     }
     func attachCompete() {
        let router = competeBuilder.build(withListener: interactor)
        competeRouter = router
        attachChild(router)
        viewController.pushViewController(router.viewControllable, animated: true)
     }
     func detachCompete() {
         guard let router = competeRouter else { return }
         viewControllable.popViewController(animated: true)
         detachChild(router)
         competeRouter = nil
     }
     func detachUserAndAttachCompete() {
         guard let router = userRouter else { return }
         viewController.dismiss(animated: true) { [weak self] in
             guard let self = self else { return }
             let router = self.competeBuilder.build(
                withListener: self.interactor
             )
             self.competeRouter = router
             self.attachChild(router)
             self.viewController.pushViewController(router.viewControllable, animated: true)
         }
         detachChild(router)
         userRouter = nil
     }
     func presentActionSheet() {
         let presentStyle = UIDevice.current.userInterfaceIdiom == .phone ? UIAlertController.Style.actionSheet : .alert
         viewControllable.presentAlert(title: "GRIG", message: "Github Rank In GSM", style: presentStyle, actions: [
            .init(title: "Join", style: .default, handler: { [weak self] _ in
                self?.viewControllable.openSafariWithUrl(url: "https://github.com/login/oauth/authorize?client_id=685ffb52e4dd768b3f66&redirect_uri=https://d6ui2fy5uj.execute-api.ap-northeast-2.amazonaws.com/api/auth&scope=user:email")
            }),
            .init(title: "Open API", style: .default, handler: { [weak self] _ in
                self?.viewControllable.openSafariWithUrl(url: "https://github.com/GRI-G/GRIG-API")
            }),
            .init(title: "About", style: .default, handler: { [weak self] _ in
                self?.attachAbout()
            }),
            .init(title: "Cancel", style: .cancel, handler: nil)
         ])
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
}
