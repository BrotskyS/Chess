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
    
    // User can press on cell only if figure exist
    func canPress() -> Bool {
        if figure != nil {
            return true
        } else {
            return false
        }
    }
    
    func isEmptyVertical(toCell: Cell, cells: [[Cell]]) -> Bool {
        if position.x != toCell.position.x {
            return false
        }
        
        let min = min(position.y, toCell.position.y)
        let max = max(position.y, toCell.position.y)
        
        for y in (min + 1)..<max {
            print("y: \(position.x) \(y), \(cells[y][position.x].isEmpty())")
            let test = cells[y][position.x]
            
            if !cells[y][position.x].isEmpty() {
                print("return")
                return false
            }
            
        }
        return true
    }
    
    func isEmptyHorizontal(toCell: Cell, cells: [[Cell]]) -> Bool {
        if position.y != toCell.position.y {
            return false
        }
        
        let min = min(position.x, toCell.position.x)
        let max = max(position.x, toCell.position.x)
        
        for x in (min + 1)..<max where !cells[position.y][x].isEmpty() {
            return false
        }
        return true
    }
    
    func isEmptyDiagonal(toCell: Cell, cells: [[Cell]]) -> Bool {
        let absX = abs(toCell.position.x - position.x)
        let absY = abs(toCell.position.y - position.y)
        
        if absX != absY {
            return false
        }
        let dy = position.y < toCell.position.y ? 1 : -1
        let dx = position.x < toCell.position.x ? 1 : -1
        
        for i in 1..<absY {
            if !cells[position.y + dy * i][position.x + dx * i].isEmpty() {
                return false
            }
        }
        
        return true
    }
    
    mutating func setFigure(_ figure: Figure) {
        self.figure = figure
    }
}
