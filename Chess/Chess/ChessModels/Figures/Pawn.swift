//
//  Pawn.swift
//  Chess
//
//  Created by Sergiy Brotsky on 20.04.2023.
//

import Foundation
import UIKit

struct Pawn: Figure {

    var image: UIImage?
    var color: FigureColor

    func canMove() -> Bool {
        return true
    }

    init(color: FigureColor) {
        self.color = color
        
        self.image = color == .white ? UIImage(named: "white-pawn") : UIImage(named: "black-pawn")
    }
}
