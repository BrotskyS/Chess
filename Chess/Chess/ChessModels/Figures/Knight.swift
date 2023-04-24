//
//  Knight.swift
//  Chess
//
//  Created by Sergiy Brotsky on 20.04.2023.
//

import Foundation
import UIKit

struct Knight: Figure {
    let type: FigureType
    let color: ColorType
    let image: UIImage?
//    var cell: Cell?
    var position: Position
    
    func canMove(toCell: Cell, cells: [[Cell]]) -> Bool {
        if !canMoveBasicRule(toCell: toCell) {
            return false
        }
        
        let cell = cells[position.y][position.x]
        let dx = abs(cell.position.x - toCell.position.x)
        let dy = abs(cell.position.y - toCell.position.y)
        
        return ((dx == 1 && dy == 2) || (dx == 2 && dy == 1))
    }
    
    init(color: ColorType, position: Position) {
        self.color = color
        
        self.image = color == .white ? UIImage(named: "white-knight") : UIImage(named: "black-knight")
        self.type = .knight
        self.position = position
    }
}
