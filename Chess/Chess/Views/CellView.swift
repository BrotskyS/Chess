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
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 8)
        label.backgroundColor = cell.color
        label.text = "\(cell.x)"
        
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
