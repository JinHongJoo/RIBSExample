//
//  OffGameViewController.swift
//  RIBSExample
//
//  Created by 주진홍 on 2023/02/17.
//

import ModernRIBs
import UIKit
import SnapKit

protocol OffGamePresentableListener: AnyObject {
    func startTicTacToe()
}

final class OffGameViewController: UIViewController, OffGamePresentable, OffGameViewControllable {
    var uiviewController: UIViewController {
       return self
   }

   weak var listener: OffGamePresentableListener?

    init(player1Name: String, player2Name: String) {
        print("\(player1Name)  \(player2Name)")
       super.init(nibName: nil, bundle: nil)
   }

   required init?(coder aDecoder: NSCoder) {
       fatalError("Method is not supported")
   }

   override func viewDidLoad() {
       super.viewDidLoad()

       view.backgroundColor = UIColor.yellow
       buildStartButton()
   }

   // MARK: - Private

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
       startButton.addTarget(self, action: #selector(tappStartButton), for: .touchUpInside)
   }
    
    @objc private func tappStartButton() {
        listener?.startTicTacToe()
    }
    
}
