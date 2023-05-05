//
//  GameViewController.swift
//  Chess
//
//  Created by Sergiy Brotsky on 04.05.2023.
//

import UIKit
import SnapKit

protocol GameViewControllerProtocol: AnyObject {
    
}

class GameViewController: UIViewController {
    var game: Game!
    
    let board = BoardView()
    let timer = TimerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let game = Game()
        game.gameView = self
        self.game = game
        view.backgroundColor = UIColor(hexString: "#1B1B1B")
        
        addBoard()
        addTimer()
    }
    
    private func addBoard() {
        view.addSubview(board)
        
        board.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(view.snp.width)
        }
    }
    
    private func addTimer() {
        
        view.addSubview(timer)
        
        timer.snp.makeConstraints { make in
            make.bottom.equalTo(board.snp.top).offset(-10)
            make.trailing.equalTo(board.snp.trailing).offset(-10)
        }
    }
}

// MARK: - GameViewControllerProtocol
extension GameViewController: GameViewControllerProtocol {
    
}
