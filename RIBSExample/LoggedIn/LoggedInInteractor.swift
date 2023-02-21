//
//  LoggedInInteractor.swift
//  RIBSExample
//
//  Created by 주진홍 on 2023/02/17.
//

import ModernRIBs

protocol LoggedInRouting: Routing {
    func cleanupViews()
    func attachOffGame()
    func attachTicTacToe()
    func routeToOffGame()
}

protocol LoggedInListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class LoggedInInteractor: Interactor, LoggedInInteractable {
    private let mutableScoreStream: MutableScoreStream
    
    weak var router: LoggedInRouting?
    weak var listener: LoggedInListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(mutableScoreStream: MutableScoreStream) {
       self.mutableScoreStream = mutableScoreStream
   }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()

        router?.cleanupViews()
        // TODO: Pause any business logic.
    }
    
    func startTicTacToe() {
        router?.attachTicTacToe()
    }
    
    func gameDidEnd(withWinner winner: PlayerType?) {
        mutableScoreStream.updateScore(withWinner: winner)
        router?.routeToOffGame()
    }
}
