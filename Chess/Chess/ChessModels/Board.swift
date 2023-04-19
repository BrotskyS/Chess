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
                let position = Position(x: j, y: i)
                let figure = getInitialFigure(position: position)
                if (i + j) % 2 != 0 {
                    let cell = Cell(position: position, color: .black, figure: figure, available: false, isSelected: false)
                    row.append(cell)
                } else {
                    let cell = Cell(position: position, color: .white, figure: figure, available: false, isSelected: false)
                    row.append(cell)
                }
            }
            cells.append(row)
            
        }
        self.cells.accept(cells)
    }
    
    func pressOn(position: Position) {
        var newCells = cells.value
        newCells[position.y][position.x].isSelected = true
        cells.accept(newCells)
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
              return Queen(color: .white)
          case (4, 0):
              return King(color: .white)
          case (0, 7), (7, 7):
              return Rook(color: .black)
          case (1, 7), (6, 7):
              return Knight(color: .black)
          case (2, 7), (5, 7):
              return Bishop(color: .black)
          case (3, 7):
              return Queen(color: .black)
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
