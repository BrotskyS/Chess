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
    var position: Position
    
    var isFirstStep: Bool = true
    
    func canMove(toCell: Cell, cells: Cells) -> Bool {
        if !canMoveBasicRule(toCell: toCell) {
            return false
        }
        let cell = cells.getCell(position)
        
        let direction = color == .black ? 1 : -1
        let firstStepDirection = color == .black ? 2 : -2
        
        let isSameY = toCell.position.y == cell.position.y + direction
        let isSameYFirstStep = isFirstStep && toCell.position.y == cell.position.y + firstStepDirection
        let isSameX = toCell.position.x == cell.position.x
        
        
        if (isSameY || isSameYFirstStep) && isSameX && cells.isEmptyVertical(fromCell: cell, toCell: toCell) && toCell.isEmpty() {
            return true
        }
        
        if isSameY && abs(toCell.position.x - cell.position.x) == 1 && cell.isEnemy(toCell: toCell) {
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
    
     func moveFigure(toCell: Cell, board: Board) {
        
    }
}
