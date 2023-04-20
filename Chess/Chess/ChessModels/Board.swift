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

class Board: BoardProtocol {
    
    weak var boardView: BoardViewProtocol?
    
    var cells: [[Cell]] = []
    
    init() {
        initCells()
    }
    
    func pressOn(position: Position) {
        var cell = cells[position.x][position.y]
        if let selectedCell = findSelectedCell(), cell.figure == nil, ((selectedCell.figure?.canMove(toCell: cell)) != nil) {
            moveFigure(from: selectedCell, to: cell)
            deselectAllCells()
        }
        // Deselect all cell and select
        if cell.figure != nil { // press on cell with figure
            deselectAllCells()
            highlightCells(selectedCell: cells[position.x][position.y])
            cell.selected = true
            cells[position.x][position.y] = cell
        } else { // press on cell without figure
            deselectAllCells()
        }
        
        
        boardView?.reloadCells()
    }
    
    private func moveFigure(from: Cell, to: Cell) {
        cells[from.position.y][from.position.x].figure = nil
        cells[to.position.y][to.position.x].figure = from.figure
    }
    
    private func findSelectedCell() -> Cell? {
        for row in cells {
            for cell in row {
                if cell.selected {
                    return cell
                }
            }
        }
        return nil
    }
    
    private func highlightCells(selectedCell cell: Cell) {
        for i in 0..<8 {
            for j in 0..<8 {
                guard let figure = cell.figure else {
                    return
                }
                
                if figure.canMove(toCell: cell) {
                    cells[i][j].available = true
                    
                }
                
            }
        }
    }
    
    private func deselectAllCells() {
        for i in 0..<8 {
            for j in 0..<8 {
                cells[i][j].selected = false
                cells[i][j].available = false
            }
        }
    }
    
    private func initCells() {
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
            self.cells.append(row)
            
        }
    }
    
    private func getCell(_ position: Position) -> Cell {
        return cells[position.x][position.y]
    }
    
    private func getInitialFigure(position: Position) -> Figure? {
        switch (position.x, position.y) {
            case (0, 0), (7, 0):
                return  Rook(color: .white)
            case (1, 0), (6, 0):
                return Knight(color: .white)
            case (2, 0), (5, 0):
                return Bishop(color: .white)
            case (3, 0):
                return Queen(color: .white, position: position)
            case (4, 0):
                return King(color: .white)
            case (0, 7), (7, 7):
                return Rook(color: .black)
            case (1, 7), (6, 7):
                return Knight(color: .black)
            case (2, 7), (5, 7):
                return Bishop(color: .black)
            case (3, 7):
                return Queen(color: .black, position: position)
            case (4, 7):
                return King(color: .black)
            case (let x, let y) where y == 1:
                return Pawn(color: .white)
            case (let x, let y) where y == 6:
                return Pawn(color: .black)
            default:
                return nil
        }
    }
}

