//
//  AppRootRouter.swift
//  RIBSExample
//
//  Created by 주진홍 on 2023/02/17.
//

import ModernRIBs

protocol AppRootInteractable: Interactable, LoggedOutListener, LoggedInListener {
    var router: AppRootRouting? { get set }
    var listener: AppRootListener? { get set }
}

protocol AppRootViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class AppRootRouter: LaunchRouter<AppRootInteractable, AppRootViewControllable>, AppRootRouting {
    private let loggedOutBuilder: LoggedOutBuildable
    private let loggedInBuilder: LoggedInBuildable
    private var loggedOut: ViewableRouting?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: AppRootInteractable,
         viewController: AppRootViewControllable,
         loggedOutBuilder: LoggedOutBuildable,
         loggedInBuilder: LoggedInBuildable
    ) {
        self.loggedOutBuilder = loggedOutBuilder
        self.loggedInBuilder = loggedInBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        
        let loggedOut = loggedOutBuilder.build(withListener: interactor)
        self.loggedOut = loggedOut
        attachChild(loggedOut)
        viewController.present(viewController: loggedOut.viewControllable)
    }
    
    func routeToLoggedIn(withPlayer1Name player1Name: String, player2Name: String) {
        if let loggedOut = loggedOut {
            detachChild(loggedOut)
            viewController.dismiss(viewController: loggedOut.viewControllable)
            self.loggedOut = nil
        }
        let loggedIn = loggedInBuilder.build(withListener: interactor,
                                             player1Name: player1Name,
                                             player2Name: player2Name
        )
        
        attachChild(loggedIn)
    }
}
