//
//  Knight.swift
//  Chess
//
//  Created by Sergiy Brotsky on 20.04.2023.
//

import Foundation
import UIKit

struct Knight: Figure {
    var color: FigureColor
    var image = UIImage(named: "black-pawn")
    
    func canMove() -> Bool {
        return true
    }
    
    init(color: FigureColor) {
        self.color = color
        
        self.image = color == .white ? UIImage(named: "white-knight") : UIImage(named: "black-knight")
    }
}
