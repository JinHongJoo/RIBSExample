//
//  OffGameInteractor.swift
//  RIBSExample
//
//  Created by 주진홍 on 2023/02/17.
//

import ModernRIBs
import RxSwift

protocol OffGameRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol OffGamePresentable: Presentable {
    var listener: OffGamePresentableListener? { get set }
    func set(score: Score)
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol OffGameListener: AnyObject {
    func startTicTacToe()
}

final class OffGameInteractor: PresentableInteractor<OffGamePresentable>, OffGameInteractable, OffGamePresentableListener {
    private let scoreStream: ScoreStream
    
    weak var router: OffGameRouting?
    weak var listener: OffGameListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(scoreStream: ScoreStream, presenter: OffGamePresentable) {
        self.scoreStream = scoreStream
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        updateScore()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func startTicTacToe() {
        listener?.startTicTacToe()
    }
    
    func updateScore() {
        scoreStream.score.subscribe(onNext: { [weak self] score in
            self?.presenter.set(score: score)
        }).dispose()
    }
}
