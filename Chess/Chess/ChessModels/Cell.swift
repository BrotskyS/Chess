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
    
    func isEmptyVertical(toCell: Cell) -> Bool {
        guard toCell.position.x != position.x else {
            return false
        }
        let min = min(position.y, toCell.position.y)
        let max = max(position.y, toCell.position.y)
        
        for y in (min + 1)..<max {
            
        }
        return true
    }
}
