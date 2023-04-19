//
//  Figure.swift
//  Chess
//
//  Created by Sergiy Brotsky on 19.04.2023.
//

import Foundation
import UIKit

enum FigureColor {
    case black
    case white
}

enum FigureType {
    case pawn
    case rook
    case knight
    case bishop
    case queen
    case king
}

protocol Figure {
    var image: UIImage? { get }
    var color: FigureColor { get }
    
    func canMove() -> Bool
    
//    init (image: UIImage?)
}
