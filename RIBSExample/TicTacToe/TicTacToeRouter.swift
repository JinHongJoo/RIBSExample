//
//  TicTacToeRouter.swift
//  RIBSExample
//
//  Created by 주진홍 on 2023/02/17.
//

import ModernRIBs

protocol TicTacToeInteractable: Interactable {
    var router: TicTacToeRouting? { get set }
    var listener: TicTacToeListener? { get set }
}

protocol TicTacToeViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class TicTacToeRouter: ViewableRouter<TicTacToeInteractable, TicTacToeViewControllable>, TicTacToeRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: TicTacToeInteractable, viewController: TicTacToeViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
