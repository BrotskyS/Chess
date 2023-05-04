//
//  ViewController.swift
//  Chess
//
//  Created by Sergiy Brotsky on 19.04.2023.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    private let openGameButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Open Game", for: .normal)
        button.backgroundColor = .red
        
        return button
    }()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(openGameButton)
        openGameButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            
        }
        
        openGameButton.rx.tap
            .bind { _ in
                self.addGame()
            }
            .disposed(by: disposeBag)
        
        addGame()
    }
    
    private func addGame() {
        let game = GameViewController()
        
        navigationController?.pushViewController(game, animated: true)
    }
}
