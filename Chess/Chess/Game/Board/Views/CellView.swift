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
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(cell: Cell) {
        
        for subview in contentView.subviews {
               subview.removeFromSuperview()
           }

        contentView.backgroundColor = cell.color == .white ? UIColor(hexString: "##EEEED2") : UIColor(hexString: "#769656")
        
        if cell.selected {
            contentView.backgroundColor = .brown
        }
        
        // figure exist on cell
//        if cell.figure != nil {
//            let image = UIImageView(image: cell.figure?.image)
//            
//            contentView.addSubview(image)
//            image.snp.makeConstraints { make in
//                make.edges.equalToSuperview()
//            }
//        }
        
        // Show dot if cell available and one cell selected
        if cell.available {
            let dotView = UIView()
            dotView.backgroundColor = .darkGray
            dotView.layer.cornerRadius = 5
            dotView.layer.masksToBounds = true
            contentView.addSubview(dotView)
            
            dotView.snp.makeConstraints { make in
                make.width.equalTo(10)
                make.height.equalTo(10)
                make.center.equalToSuperview()
                
            }
        }
        
        if false { // enable for debelopment
            let labelPosition = UILabel()
            
            labelPosition.text = "\(cell.position.y), \(cell.position.x)"
            labelPosition.textColor = .blue
            labelPosition.font = .systemFont(ofSize: 10)
            contentView.addSubview(labelPosition)
            
            labelPosition.snp.makeConstraints { make in
                make.leading.equalTo(0)
                make.bottom.equalTo(0)
                
            }
        }
        
    }
}
