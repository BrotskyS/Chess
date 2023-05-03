//
//  Board.swift
//  Chess
//
//  Created by Sergiy Brotsky on 19.04.2023.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol BoardProtocol: AnyObject {
    func pressOn(position: Position)
}

final class Board: BoardProtocol {
    weak var boardView: BoardViewProtocol?
    
    var cells = Cells()

    init() {
        initCells()
    }
    
    func canSelectCell(cell: Cell) -> Bool {
        let lastMove = cells.historyMoves.last
        
        if lastMove == nil && cell.figure?.color == .white {
            return true
        }
        if  let lastMove = lastMove, lastMove.figure.color != cell.figure?.color {
            return true
        }
        
        return false
    }
    
    func pressOn(position: Position) {
        
        var cell = cells.getCell(position) // get cell
     
        // if selectedCell exist, figure on selectedCell exist and can this figure move
        if let selectedCell = cells.getSelectedCell(),
           let selectedFigure = selectedCell.figure,
           selectedFigure.canMove(toCell: cell, cells: cells) {
            moveFigure(from: selectedCell, to: cell)
            cells.deselectAllCells()
            boardView?.reloadCells()
            return
        }
        
        if cell.figure != nil && canSelectCell(cell: cell) { // press on cell with figure
            cells.deselectAllCells()
            cells.highlightCells(selectedCell: cell)
            cell.selected = true
            cells.cells[position.y][position.x] = cell
        } else { // press on cell without figure
            cells.deselectAllCells()
        }
        boardView?.reloadCells()
  
    }
    
    func moveFigure(from: Cell, to: Cell) {
        guard var figure = from.figure else {
            return
        }
        boardView?.moveFigure(from: from, to: to)
        figure.moveFigure(toCell: to, board: self)
        cells.makeMove(from: from.position, to: to.position, figure: figure)
       
        deleteFigure(from.position)

        figure.isFirstStep = false
        figure.setPosition(to.position)
        cells.cells[to.position.y][to.position.x].figure = figure
       
    }
    
    func deleteFigure(_ from: Position) {
        cells.cells[from.y][from.x].figure = nil
    }
    
    func initCells() {
        for i in 0..<8 {
            var row: [Cell] = []
            for j in 0..<8 {
                let position = Position(x: j, y: i)
                let figure = getInitialFigure(position: position)
                if (i + j) % 2 != 0 {
                    let cell = Cell(position: position, color: .black, figure: figure, available: false, selected: false)
                    
                    row.append(cell)
                } else {
                    let cell = Cell(position: position, color: .white, figure: figure, available: false, selected: false)
                    row.append(cell)
                }
            }
            self.cells.cells.append(row)
            
        }
    }
    
    private func getInitialFigure(position: Position) -> (any Figure)? {
        switch (position.x, position.y) {
            case (0, 0), (7, 0):
                return  Rook(color: .black, position: position)
            case (1, 0), (6, 0):
                return Knight(color: .black, position: position)
            case (2, 0), (5, 0):
                return Bishop(color: .black, position: position)
            case (3, 0):
                return Queen(color: .black, position: position)
            case (4, 0):
                return King(color: .black, position: position)
            case (0, 7), (7, 7):
                return Rook(color: .white, position: position)
            case (1, 7), (6, 7):
                return Knight(color: .white, position: position)
            case (2, 7), (5, 7):
                return Bishop(color: .white, position: position)
            case (3, 7):
                return Queen(color: .white, position: position)
            case (4, 7):
                return King(color: .white, position: position)
//            case (_, let y) where y == 1:
//                return Pawn(color: .black, position: position)
//            case (_, let y) where y == 6:
//                return Pawn(color: .white, position: position)
            default:
                return nil
        }
    }
}
