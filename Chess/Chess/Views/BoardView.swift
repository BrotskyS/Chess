//
//  BoardView.swift
//  Chess
//
//  Created by Sergiy Brotsky on 19.04.2023.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

protocol BoardViewProtocol: AnyObject {
    func reloadCells()
    func moveFigure(from: Cell, to: Cell)
}

class BoardView: UIView {
    
    let boardSize = 8
    
    var board: Board!
    
    let figures = UIView()
//        lazy var figures: UIView = {
//            let view = UIView()
//
//            for cellRow in board.cells.cells {
//                for cellCol in cellRow {
//                    let indexPathInt = board.cells.getIndexPathInt(cellCol.position)
//                    let cell = collectionView.cellForItem(at: IndexPath(item: indexPathInt, section: 0))
//
//                    let imageView = UIImageView()
//                    imageView.image = UIImage(named: "white-knight")
//                    imageView.frame = CGRect(x: cell?.frame.width ?? 0, y: cell?.frame.height ?? 0, width: 30, height: 30)
//                    view.addSubview(imageView)
//
//                }
//                //
//            }
//
//            return view
//        }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 0.0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(CellView.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //        board.initCells()
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //        addSubview(figures)
    }
//    func viewDidAppear() {
//        addSubview(figures)
//    }

    override func layoutSubviews() {
        addSubview(figures)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadBoard() {
        collectionView.reloadData()
    }
}

extension BoardView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return board.cells.cells.count * board.cells.cells[0].count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CellView else {
            return UICollectionViewCell()
        }
        
        let row = indexPath.item / boardSize
        let column = indexPath.item % boardSize
        
        let cellData = board.cells.cells[row][column]
        
        cell.configure(cell: cellData)
//
//        let test = figures.viewWithTag(0)
//        if  cellData.figure?.position.x == 5 &&  cellData.figure?.position.y == 5 {
//            print("figure.id.hashValue: \(cellData.figure?.id.uuidString)")
//
//        }
        
        
        if let figure = cellData.figure, (figures.viewWithTag(figure.position.hashValue) == nil) {
            
            let imageView = UIImageView(image: figure.image)
            imageView.frame = cell.frame
            imageView.tag =  figure.position.hashValue
            figures.addSubview(imageView)
        } else {
//            let view = UIView()
//            view.tag =  cellData.position.hashValue
//            figures.addSubview(view)
        }
        
        return cell
    }
    
}

extension BoardView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.item / boardSize
        let column = indexPath.item % boardSize
        
        board.pressOn(position: Position(x: column, y: row))
        
    }

}

extension BoardView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width / CGFloat(boardSize)
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
}

extension BoardView: BoardViewProtocol {
    func reloadCells() {
        collectionView.reloadData()
    }
    
    func moveFigure(from: Cell, to: Cell) {
        let toCellIndexPath = board.cells.getIndexPathInt(to.position)
        let fromCellIndexPath = board.cells.getIndexPathInt(from.position)
        let fromFigure = from.figure?.position.hashValue ?? 0
        guard let toCell = collectionView.cellForItem(at: IndexPath(item: toCellIndexPath, section: 0)) else {

            return
        }

        if let toFigure = to.figure {
            UIView.animate(withDuration: 0.1) {
                self.figures.viewWithTag(toFigure.position.hashValue)?.removeFromSuperview()
            }
        }
        
        UIView.animate(withDuration: 0.2) {
            self.figures.viewWithTag(from.position.hashValue)?.frame = toCell.frame
        }
        self.figures.viewWithTag(from.position.hashValue)?.tag = to.position.hashValue
        
    }
}
