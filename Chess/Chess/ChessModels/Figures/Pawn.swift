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
        if cell.isEmptyDiagonal(toCell: toCell, cells: cells) {
            
            return true
        }
        
        return false
    }

    init(color: ColorType, position: Position) {
        self.color = color
        
        self.image = color == .white ? UIImage(named: "white-pawn") : UIImage(named: "black-pawn")
        self.type = .pawn
        self.position = position
    }
}
