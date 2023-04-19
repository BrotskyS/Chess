//
//  Cell.swift
//  Chess
//
//  Created by Sergiy Brotsky on 19.04.2023.
//

import Foundation

enum CellColor {
    case black
    case white
}

struct Cell {
    let id = UUID().uuidString
    var position: Position
    let color: CellColor
    var figure: Figure?
    var available: Bool
    var isSelected: Bool
}
