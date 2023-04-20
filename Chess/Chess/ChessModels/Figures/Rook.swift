//
//  Rook.swift
//  Chess
//
//  Created by Sergiy Brotsky on 20.04.2023.
//

import Foundation
import UIKit

struct Rook: Figure {
    let type: FigureType
    let color: ColorType
    let image: UIImage?
    var cell: Cell?
    var position: Position?
    
    func canMove(toCell: Cell) -> Bool {
        return true
    }
    
    init(color: ColorType) {
        self.color = color
        
        self.image = color == .white ? UIImage(named: "white-rook") : UIImage(named: "black-rook")
        self.type = .rook
    }
}
