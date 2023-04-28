//
//  Cell.swift
//  Chess
//
//  Created by Sergiy Brotsky on 19.04.2023.
//

import Foundation

enum ColorType: Equatable {
    case black
    case white
}

struct Cells {
    var cells: [[Cell]] = []
    var historyMoves: [Move] = []
    
    mutating func makeMove(from: Position, to: Position, figure: Figure) {
        let move = Move(from: from, to: to, figure: figure)
        historyMoves.append(move)
    }
    func isValidPosition(position: Position) -> Bool {
        return (0..<8).contains(position.y) && (0..<8).contains(position.x)
    }
    
    func getCell(_ position: Position) -> Cell {
        return cells[position.y][position.x]
    }
    
    func findSelectedCell() -> Cell? {
        for row in cells {
            for cell in row where cell.selected {
                return cell
            }
        }
        return nil
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
                
                if figure.canMove(toCell: toCell, cells: self) && !isCheck(fromCell: selectedCell, toCell: toCell) {
                    cells[i][j].available = true
                }
            }
        }
    }
    
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

    func isCheck(fromCell: Cell, toCell: Cell) -> Bool {
        
        guard var figure = fromCell.figure else {
            return false
        }
        var copyCells = Cells(cells: self.cells)
           
        copyCells.cells[fromCell.position.y][fromCell.position.x].figure = nil

        figure.setPosition(toCell.position)
        copyCells.cells[toCell.position.y][toCell.position.x].figure = figure

        guard let king = findKingPosition(color: figure.color, cells: copyCells.cells) else {
            return false
        }

        for i in 0..<8 {
            for j in 0..<8 {
                
                let cell = copyCells.cells[i][j]
                if cell.figure != nil && cell.figure?.canMove(toCell: king, cells: copyCells) == true {
                    return true
                }
            }
        }

        return false
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

struct Cell: Identifiable {
    let id = UUID().uuidString
    var position: Position
    let color: ColorType
    var figure: Figure?
    var available: Bool
    var selected: Bool
    
    func isAvailable() -> Bool {
        guard figure != nil else {
            return false
        }
        
        return true
    }
    
    func isEmpty() -> Bool {
        return figure == nil
    }
    
    func isEnemy(toCell: Cell) -> Bool {
        if toCell.figure != nil {
            return figure?.color != toCell.figure?.color
        } else {
            return false
        }
    }
    
    // User can press on cell only if figure exist
    func canPress() -> Bool {
        if figure != nil {
            return true
        } else {
            return false
        }
    }
    
    mutating func setFigure(_ figure: Figure) {
        self.figure = figure
    }
    static func placeholder() -> Cell {
        return Cell(position: Position(x: 0, y: 0), color: .black, available: false, selected: false)
    }
}
