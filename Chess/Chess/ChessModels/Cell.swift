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
