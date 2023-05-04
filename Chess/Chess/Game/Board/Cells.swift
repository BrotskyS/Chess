//
//  Cells.swift
//  Chess
//
//  Created by Sergiy Brotsky on 29.04.2023.
//

import Foundation

struct Cells {
    var cells: [[Cell]] = []
    var historyMoves: [Move] = []
    
    // MARK: - Get utility
    func isValidPosition(position: Position) -> Bool {
        return (0..<8).contains(position.y) && (0..<8).contains(position.x)
    }
    
    func getCell(_ position: Position) -> Cell {
        return cells[position.y][position.x]
    }
  
    func getSelectedCell() -> Cell? {
        for row in cells {
            for cell in row where cell.selected {
                return cell
            }
        }
        return nil
    }
    
    func getIndexPathInt(_ position: Position) -> Int {
        return (position.y) * 8 + position.x
    }
    // MARK: - mutating
    
    mutating func makeMove(from: Position, to: Position, figure: any Figure) {
        let move = Move(from: from, to: to, figure: figure)
        historyMoves.append(move)
    }
    
    mutating func deleteFigure(_ from: Position) {
        cells[from.y][from.x].figure = nil
    }
    
    mutating func deselectAllCells() {
        for i in 0..<8 {
            for j in 0..<8 {
                cells[i][j].selected = false
                cells[i][j].available = false
            }
        }
    }
    
    mutating func highlightCells(selectedCell: Cell) {
        for i in 0..<8 {
            for j in 0..<8 {
                guard let figure = selectedCell.figure else {
                    return
                }
                let toCell = cells[i][j]
                
                let fakeMoveCells = fakeMove(fromCell: selectedCell, toCell: toCell)
                if figure.canMove(toCell: toCell, cells: self) && !isCheck(fromCell: selectedCell, toCell: toCell, cells: fakeMoveCells) {
                    cells[i][j].available = true
                }
            }
        }
    }
    
    func isCheck(fromCell: Cell, toCell: Cell, cells: Cells) -> Bool {
        guard let figure = fromCell.figure else {
            return false
        }
        
        guard let king = findKingPosition(color: figure.color, cells: cells.cells) else {
            return false
        }
        
        for i in 0..<8 {
            for j in 0..<8 {
                
                let cell = cells.cells[i][j]
                if cell.figure != nil && cell.figure?.canMove(toCell: king, cells: cells) == true {
                    return true
                }
            }
        }
        
        return false
    }
    
}

// MARK: - Private
private extension Cells {
    func fakeMove(fromCell: Cell, toCell: Cell) -> Cells {
        var figure = fromCell.figure
        
        var copyCells = Cells(cells: self.cells)
        
        copyCells.cells[fromCell.position.y][fromCell.position.x].figure = nil
        
        figure?.setPosition(toCell.position)
        copyCells.cells[toCell.position.y][toCell.position.x].figure = figure
        
        return copyCells
    }
    
    func findKingPosition(color: ColorType, cells: [[Cell]]) -> Cell? {
        for i in 0..<8 {
            for j in 0..<8 {
                let cell = cells[i][j]
                if let figure = cell.figure, figure.type == .king, figure.color == color {
                    return cell
                }
            }
        }
        return nil
    }
}

// MARK: - Is empty lines
extension Cells {
    func isEmptyVertical(fromCell: Cell, toCell: Cell) -> Bool {
        if fromCell.position.x != toCell.position.x {
            return false
        }
        
        let min = min(fromCell.position.y, toCell.position.y)
        let max = max(fromCell.position.y, toCell.position.y)
        
        for y in (min + 1)..<max where !cells[y][fromCell.position.x].isEmpty() {
            return false
        }
        return true
    }
    
    func isEmptyHorizontal(fromCell: Cell, toCell: Cell) -> Bool {
        if fromCell.position.y != toCell.position.y {
            return false
        }
        
        let min = min(fromCell.position.x, toCell.position.x)
        let max = max(fromCell.position.x, toCell.position.x)
        
        for x in (min + 1)..<max where !cells[fromCell.position.y][x].isEmpty() {
            return false
        }
        return true
    }
    
    func isEmptyDiagonal(fromCell: Cell, toCell: Cell) -> Bool {
        let absX = abs(toCell.position.x - fromCell.position.x)
        let absY = abs(toCell.position.y - fromCell.position.y)
        
        if absX != absY {
            return false
        }
        let dy = fromCell.position.y < toCell.position.y ? 1 : -1
        let dx = fromCell.position.x < toCell.position.x ? 1 : -1
        
        for i in 1..<absY where !cells[fromCell.position.y + dy * i][fromCell.position.x + dx * i].isEmpty() {
            return false
        }
        
        return true
    }
}
