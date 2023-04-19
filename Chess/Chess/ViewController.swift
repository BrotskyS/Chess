//
//  ViewController.swift
//  Chess
//
//  Created by Sergiy Brotsky on 19.04.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    private var chessboardView =  ChessboardView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        view.addSubview(boardView)
    
        view.addSubview(chessboardView)
        chessboardView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(view.snp.width)
        }
    }

    //        view.present(boardView, animated: true)
    // Do any additional setup after loading the view.
    
}
