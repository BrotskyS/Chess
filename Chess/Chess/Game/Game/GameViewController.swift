//
//  GameViewController.swift
//  Chess
//
//  Created by Sergiy Brotsky on 04.05.2023.
//

import UIKit

protocol GameViewControllerProtocol: AnyObject {
    
}

class GameViewController: UIViewController {
    var game: Game!
    
    let board = BoardView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let game = Game()
        game.gameView = self
        self.game = game
        view.backgroundColor = .systemBackground
        
        addBoard()
    }
    
    private func addBoard() {
        view.addSubview(board)
        
        board.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(view.snp.width)
        }
    }
}

// MARK: - GameViewControllerProtocol
extension GameViewController: GameViewControllerProtocol {
    
}
