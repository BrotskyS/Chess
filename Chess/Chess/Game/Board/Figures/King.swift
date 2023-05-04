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
    var position: Position
    var isFirstStep: Bool = true
    
    init(color: ColorType, position: Position) {
        self.color = color
        
        self.image = color == .white ? UIImage(named: "white-king") : UIImage(named: "black-king")
        self.type = .king
        self.position = position
    }
    
    func canMove(toCell: Cell, cells: Cells) -> Bool {
        if !canMoveBasicRule(toCell: toCell) {
            return false
        }
//        
        let cell = cells.getCell(position)
        
        // basic role for king
        if abs(toCell.position.x - cell.position.x) <= 1 && abs(toCell.position.y - cell.position.y) <= 1 {
            return toCell.isEmpty() || cell.isEnemy(toCell: toCell)
        }
       
        // Check is king can castle
        if canCastle(toCell: toCell, cells: cells) != nil {
            return true
        }
        
        return false
    }
    
    private func isCheckInHorizontal(fromCell: Cell, toCell: Cell, cells: Cells) -> Bool {
        if fromCell.position.y != toCell.position.y {
            return false
        }
        
        let min = min(fromCell.position.x, toCell.position.x)
        let max = max(fromCell.position.x, toCell.position.x)
        
        for x in (min + 1)..<max where cells.isCheck(fromCell: fromCell, toCell: cells.cells[fromCell.position.y][x], cells: cells) {
            
            return true
        }
        return false
    }
    
    private func canCastle(toCell: Cell, cells: Cells) -> (from: Cell, to: Cell)? {
        guard isFirstStep == true else {
            return nil
        }
        let cell = cells.getCell(position)
        let kingRookCell = color == .white ? cells.cells[7][7] : cells.cells[0][7]
        let queenRookCell = color == .white ? cells.cells[7][0] : cells.cells[0][0]
        
        guard (
            kingRookCell.figure?.type == .rook &&
            kingRookCell.figure?.isFirstStep == true &&
            cells.isEmptyHorizontal(fromCell: cell, toCell: kingRookCell) &&
            !isCheckInHorizontal(fromCell: cell, toCell: kingRookCell, cells: cells)
        ) ||
            (queenRookCell.figure?.type == .rook &&
             queenRookCell.figure?.isFirstStep == true &&
             cells.isEmptyHorizontal(fromCell: cell, toCell: queenRookCell)) &&
                !isCheckInHorizontal(fromCell: cell, toCell: queenRookCell, cells: cells)
        else {
            return nil
        }
        
        if toCell.position.x - cell.position.x == 2 && toCell.position.y == cell.position.y {
            return (kingRookCell, cells.cells[kingRookCell.position.y][kingRookCell.position.x - 2])
        }
        if toCell.position.x - cell.position.x == -2 && toCell.position.y == cell.position.y {
            return (queenRookCell, cells.cells[queenRookCell.position.y][queenRookCell.position.x + 3])
        }
        return nil
    }
   
    func moveFigure(toCell: Cell, board: Board) {
         if let canCastle = canCastle(toCell: toCell, cells: board.cells) {
             board.moveFigure(from: canCastle.from, to: canCastle.to)
         }
    }
}
