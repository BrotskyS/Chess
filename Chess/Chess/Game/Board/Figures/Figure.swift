//
//  Figure.swift
//  Chess
//
//  Created by Sergiy Brotsky on 19.04.2023.
//

import Foundation
import UIKit

enum FigureType {
    case pawn
    case rook
    case knight
    case bishop
    case queen
    case king
}

protocol Figure: Identifiable {
    var id: UUID { get }
    var type: FigureType { get }
    var image: UIImage? { get }
    var color: ColorType { get }
    var position: Position { get set }
    var isFirstStep: Bool { get set }
    
    func canMove(toCell: Cell, cells: Cells) -> Bool
    func moveFigure(toCell: Cell, board: Board)
}

extension Figure {
    var id: UUID { UUID() }
    func canMoveBasicRule(toCell: Cell) -> Bool {
        if toCell.figure?.color == color {
            return false
        }
//        else if toCell.figure?.type == .king {
//            return false
//        }
        else {
            return true
        }
    }
    
    mutating func setPosition(_ position: Position) {
        self.position = position
    }
    
}
