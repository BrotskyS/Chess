//
//  CellView.swift
//  Chess
//
//  Created by Sergiy Brotsky on 19.04.2023.
//

import Foundation
import UIKit

class CellView: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //        reuseIdentifier = "cell"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ cell: Cell) {
        contentView.backgroundColor = cell.color == .black ? .darkGray : .gray
        
        if cell.isSelected {
            contentView.backgroundColor = .red
        }
        
        // figure exist on cell
        if cell.figure != nil {
            let image = UIImageView(image: cell.figure?.image)
            
            contentView.addSubview(image)
            image.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
    }
}
