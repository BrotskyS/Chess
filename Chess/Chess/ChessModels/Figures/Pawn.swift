//
//  Pawn.swift
//  Chess
//
//  Created by Sergiy Brotsky on 20.04.2023.
//

import Foundation
import UIKit

struct Pawn: Figure {
    let type: FigureType
    let image: UIImage?
    let color: ColorType
    var cell: Cell?
    var position: Position?

    func canMove(toCell: Cell) -> Bool {
//        guard canMoveBasicRule(toCell: toCell) else {
//            return false
//        }
        
        return true
    }

    init(color: ColorType) {
        self.color = color
        
        self.image = color == .white ? UIImage(named: "white-pawn") : UIImage(named: "black-pawn")
        self.type = .pawn
    }
}
