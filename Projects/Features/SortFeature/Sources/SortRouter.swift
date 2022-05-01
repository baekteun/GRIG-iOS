//
//  SortRouter.swift
//  SortFeature
//
//  Created by 최형우 on 2022/05/01.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RIBs

protocol SortInteractable: Interactable {
    var router: SortRouting? { get set }
    var listener: SortListener? { get set }
}

protocol SortViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SortRouter: ViewableRouter<SortInteractable, SortViewControllable>, SortRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SortInteractable, viewController: SortViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
