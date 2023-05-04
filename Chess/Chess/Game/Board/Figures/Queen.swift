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
    
    var position: Position
    var isFirstStep: Bool = true
    
    func canMove(toCell: Cell, cells: Cells) -> Bool {
        if !canMoveBasicRule(toCell: toCell) {
            return false
        }
        
        let cell = cells.getCell(position)
        
        if cells.isEmptyVertical(fromCell: cell, toCell: toCell) {
            
            return true
        }
        
        if cells.isEmptyHorizontal(fromCell: cell, toCell: toCell) {
            
            return true
        }
        if cells.isEmptyDiagonal(fromCell: cell, toCell: toCell) {
            
            return true
        }
        return false
    }
    
    init(color: ColorType, position: Position) {
        self.color = color
        
        self.image = color == .white ? UIImage(named: "white-queen") : UIImage(named: "black-queen")
        self.type = .queen
        self.position = position
    }
    
     func moveFigure(toCell: Cell, board: Board) {
    }
    
}
