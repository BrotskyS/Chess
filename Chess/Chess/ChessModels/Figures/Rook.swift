//
//  Rook.swift
//  Chess
//
//  Created by Sergiy Brotsky on 20.04.2023.
//

import Foundation
import UIKit

struct Rook: Figure {
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
        
        if cell.isEmptyVertical(toCell: toCell, cells: cells) {
            
            return true
        }
        
        if cell.isEmptyHorizontal(toCell: toCell, cells: cells) {
            
            return true
        }
    
        return true
    }
    
    init(color: ColorType, position: Position) {
        self.color = color
        
        self.image = color == .white ? UIImage(named: "white-rook") : UIImage(named: "black-rook")
        self.type = .rook
        self.position = position
    }
}
