//
//  King.swift
//  Chess
//
//  Created by Sergiy Brotsky on 20.04.2023.
//

import Foundation
import UIKit

struct King: Figure {
    let type: FigureType
    let color: ColorType
    let image: UIImage?
//    var cell: Cell?
    var position: Position
    
    func canMove(toCell: Cell, cells: [[Cell]]) -> Bool {
        return true
    }
    
    init(color: ColorType, position: Position) {
        self.color = color
        
        self.image = color == .white ? UIImage(named: "white-king") : UIImage(named: "black-king")
        self.type = .king
        self.position = position
    }
}
