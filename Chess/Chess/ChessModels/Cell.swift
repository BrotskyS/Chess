//
//  Cell.swift
//  Chess
//
//  Created by Sergiy Brotsky on 19.04.2023.
//

import Foundation
import UIKit

struct Cell: Identifiable {
    let id = UUID().uuidString
    let x: Int
    let y: Int
    let color: UIColor
    var figure: FigureType
    var available: Bool
    
}
