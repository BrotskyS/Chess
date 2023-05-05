//
//  GameViewController.swift
//  Chess
//
//  Created by Sergiy Brotsky on 04.05.2023.
//

import UIKit
import SnapKit

protocol GameViewControllerProtocol: AnyObject {
    func updateWhiteTimer(time: Int, color: ColorType)
    func updateBlackTimer(time: Int, color: ColorType)
}

class GameViewController: UIViewController {
    var game: Game!
    
    let board = ModuleBuilder.board()
    let whiteTimer = TimerView()
    let blackTimer = TimerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "#1B1B1B")
        
        addBoard()
        addTimer()
        
        board.board.delegate = game
    }
    
    private func addBoard() {
        view.addSubview(board)
        
        board.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(view.snp.width)
        }
    }
    
    private func addTimer() {

        view.addSubview(whiteTimer)

        whiteTimer.snp.makeConstraints { make in
            make.bottom.equalTo(board.snp.top).offset(-10)
            make.trailing.equalTo(board.snp.trailing).offset(-10)
        }

        view.addSubview(blackTimer)

        blackTimer.snp.makeConstraints { make in
            make.top.equalTo(board.snp.bottom).offset(10)
            make.trailing.equalTo(board.snp.trailing).offset(-10)
        }
    }
}

// MARK: - GameViewControllerProtocol
extension GameViewController: GameViewControllerProtocol {
    func updateWhiteTimer(time: Int, color: ColorType) {
        whiteTimer.updateTimer(time: time)
        whiteTimer.updateIsRunningIcon(isRunning: true)
        blackTimer.updateIsRunningIcon(isRunning: false)
    }
    
    func updateBlackTimer(time: Int, color: ColorType) {
        blackTimer.updateTimer(time: time)
        whiteTimer.updateIsRunningIcon(isRunning: false)
        whiteTimer.updateIsRunningIcon(isRunning: true)
    }
    
}
