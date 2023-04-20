//
//  Queen.swift
//  Chess
//
//  Created by Sergiy Brotsky on 20.04.2023.
//

import Foundation
import UIKit

struct Queen: Figure {
    let type: FigureType
    let color: ColorType
    let image: UIImage?
    var cell: Cell?
    var position: Position?
    
    func canMove(toCell: Cell) -> Bool {
        guard canMoveBasicRule(toCell: toCell) else {
            return false
        }
        
        return false
    }
    
    init(color: ColorType, position: Position) {
        self.color = color
        
        self.image = color == .white ? UIImage(named: "white-queen") : UIImage(named: "black-queen")
        self.type = .queen
        self.position = position
    }
}
