//
//  ModuleBuilder.swift
//  Chess
//
//  Created by Sergiy Brotsky on 05.05.2023.
//

import Foundation

class ModuleBuilder {
    static func game() -> GameViewController {
        let gameView = GameViewController()
        let game = Game(gameView: gameView)
        gameView.game = game
    
        return gameView
    }
    
    static func board() -> BoardView {
        let boardView = BoardView()
        let board = Board(boardView: boardView)
        boardView.board = board
        
        return boardView
    }
}
