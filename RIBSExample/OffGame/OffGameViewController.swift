//
//  OffGameViewController.swift
//  RIBSExample
//
//  Created by 주진홍 on 2023/02/17.
//

import ModernRIBs
import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol OffGamePresentableListener: AnyObject {
    func startTicTacToe()
}

final class OffGameViewController: UIViewController, OffGamePresentable, OffGameViewControllable {
    var uiviewController: UIViewController {
        return self
    }

    weak var listener: OffGamePresentableListener?

    init(player1Name: String, player2Name: String) {
        self.player1Name = player1Name
        self.player2Name = player2Name
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Method is not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.yellow
        buildStartButton()
        buildPlayerLabels()
    }

    // MARK: - OffGamePresentable

    func set(score: Score) {
        self.score = score
    }

    // MARK: - Private

    private let player1Name: String
    private let player2Name: String

    private var player1Label: UILabel?
    private var player2Label: UILabel?
    private var score: Score?

    private func buildStartButton() {
        let startButton = UIButton()
        view.addSubview(startButton)
        startButton.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.center.equalTo(self.view.snp.center)
            maker.leading.trailing.equalTo(self.view).inset(40)
            maker.height.equalTo(100)
        }
        startButton.setTitle("Start Game", for: .normal)
        startButton.setTitleColor(UIColor.white, for: .normal)
        startButton.backgroundColor = UIColor.black
        startButton.rx.tap
            .subscribe(
                onNext: { [weak self] in
                    self?.listener?.startTicTacToe()
                }
            )
            .disposed(by: disposeBag)
    }

    private func buildPlayerLabels() {
        let labelBuilder: (UIColor) -> UILabel = { (color: UIColor) in
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 35)
            label.backgroundColor = UIColor.clear
            label.textColor = color
            label.textAlignment = .center
            return label
        }

        let player1Label = labelBuilder(PlayerType.player1.color)
        self.player1Label = player1Label
        view.addSubview(player1Label)
        player1Label.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(self.view).offset(70)
            maker.leading.trailing.equalTo(self.view).inset(20)
            maker.height.equalTo(40)
        }

        let vsLabel = UILabel()
        vsLabel.font = UIFont.systemFont(ofSize: 25)
        vsLabel.backgroundColor = UIColor.clear
        vsLabel.textColor = UIColor.darkGray
        vsLabel.textAlignment = .center
        vsLabel.text = "vs"
        view.addSubview(vsLabel)
        vsLabel.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(player1Label.snp.bottom).offset(10)
            maker.leading.trailing.equalTo(player1Label)
            maker.height.equalTo(20)
        }

        let player2Label = labelBuilder(PlayerType.player2.color)
        self.player2Label = player2Label
        view.addSubview(player2Label)
        player2Label.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(vsLabel.snp.bottom).offset(10)
            maker.height.leading.trailing.equalTo(player1Label)
        }

        updatePlayerLabels()
    }

    private func updatePlayerLabels() {
        let player1Score = score?.player1Score ?? 0
        player1Label?.text = "\(player1Name) (\(player1Score))"

        let player2Score = score?.player2Score ?? 0
        player2Label?.text = "\(player2Name) (\(player2Score))"
    }

    private let disposeBag = DisposeBag()
}

extension PlayerType {

    var color: UIColor {
        switch self {
        case .player1:
            return UIColor.red
        case .player2:
            return UIColor.blue
        }
    }
}
