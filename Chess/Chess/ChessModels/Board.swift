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

class Board {
    let cells = BehaviorRelay<[[Cell]]>(value: [])
    
    init() {
        initCells()
    }
    
    func initCells() {
        var cells: [[Cell]] = []
        for i in 0..<8 {
            var row: [Cell] = []
            for j in 0..<8 {
                if (i + j) % 2 != 0 {
                    row.append(Cell(x: j, y: i, color: UIColor.black, figure: .pawn, available: false))
                } else {
                    row.append(Cell(x: j, y: i, color: UIColor.white, figure: .pawn, available: false))
                }
            }
            // Add row to self.cells
            cells.append(row)
        }
        self.cells.accept(cells)
    }
}
