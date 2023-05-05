//
//  Game.swift
//  Chess
//
//  Created by Sergiy Brotsky on 04.05.2023.
//

import Foundation

final class Game {
    weak var gameView: GameViewControllerProtocol?
    
    var timer = Timer()
    
    var whiteRemainingTime = 10 * 60 // 10 minutes
    var blackRemainingTime = 10 * 60 //  10 minutes
    
    var currentMoveColorType: ColorType = .white
    
    init(gameView: GameViewControllerProtocol) {
        self.gameView = gameView
//        toggleTimer(color: .white)
        
    }
    
    func toggleTimer(color: ColorType) {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            
            if self.currentMoveColorType == .white {
                self.whiteRemainingTime -= 1
                self.gameView?.updateWhiteTimer(time: self.whiteRemainingTime, color: .white)
            } else {
                self.blackRemainingTime -= 1
                self.gameView?.updateBlackTimer(time: self.blackRemainingTime, color: .white)
            }
         
//            self.gameView?.updateTimer(time: self.whiteRemainingTime)
        })
      
    }
}

extension Game: BoardDelegate {
    func makeMove(from: Position, to: Position, figure: any Figure) {
        currentMoveColorType = figure.color == .white ? .white  : .black
        toggleTimer(color: figure.color)
    }
}
