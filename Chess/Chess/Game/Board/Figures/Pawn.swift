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
    
    init(color: ColorType, position: Position) {
        self.color = color
        
        self.image = color == .white ? UIImage(named: "white-pawn") : UIImage(named: "black-pawn")
        self.type = .pawn
        self.position = position
    }
    
    func canMove(toCell: Cell, cells: Cells, isHighlightCells: Bool) -> Bool {
        if !canMoveBasicRule(toCell: toCell) {
            return false
        }
        let cell = cells.getCell(position)
        
        let direction = color == .black ? 1 : -1
        let firstStepDirection = color == .black ? 2 : -2
        
        let isSameY = toCell.position.y == cell.position.y + direction
        let isSameYFirstStep = isFirstStep && toCell.position.y == cell.position.y + firstStepDirection
        let isSameX = toCell.position.x == cell.position.x
        
        if (isSameY || isSameYFirstStep) && isSameX && cells.isEmptyVertical(fromCell: cell, toCell: toCell) && toCell.isEmpty() { // Move without enemy
            return true
        }
        
        if isSameY && abs(toCell.position.x - cell.position.x) == 1 && cell.isEnemy(toCell: toCell) { // move to enemy
            return true
        }
        
        // MARK: - En Passant
        if isEnPassant(toCell: toCell, cells: cells) != nil {
            return true
        }
        return false
    }
    
    private func isEnPassant(toCell: Cell, cells: Cells) -> Position? {
        let cell = cells.getCell(position)
        
        let direction = color == .black ? 1 : -1
        let isSameY = toCell.position.y == cell.position.y + direction
        
        let enemyY = toCell.position.y - direction
        let enemyX = toCell.position.x
        guard cells.isValidPosition(position: Position(x: enemyX, y: enemyY)) else {
            return nil
        }
        
        guard let enemyPawn = cells.cells[enemyY][enemyX].figure else {
            return nil
        }
        
        guard let lastMove =  cells.historyMoves.last else {
            return nil
        }
        
        guard lastMove.figure.type == .pawn && abs(lastMove.from.y - lastMove.to.y) == 2 && lastMove.to == enemyPawn.position  else {
            return nil
        }
        
        if isSameY && abs(toCell.position.x - cell.position.x) == 1 && enemyPawn.type == .pawn && enemyPawn.color != color {
            
            return enemyPawn.position
        }
        return nil
    }
    
    func moveFigure(toCell: Cell, board: Board) {
        
        if let position = isEnPassant(toCell: toCell, cells: board.cells) {
            
            board.deleteFigure(position)
        }
    }
}
