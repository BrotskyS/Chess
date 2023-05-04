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
    var position: Position
    var isFirstStep: Bool = true
    
    func canMove(toCell: Cell, cells: Cells, isHighlightCells: Bool) -> Bool {
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
    
        return false
    }
    
    init(color: ColorType, position: Position) {
        self.color = color
        
        self.image = color == .white ? UIImage(named: "white-rook") : UIImage(named: "black-rook")
        self.type = .rook
        self.position = position
    }
    
     func moveFigure(toCell: Cell, board: Board) {
        
    }
    
}
