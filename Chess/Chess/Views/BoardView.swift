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

class ChessboardView: UIView {
    
    private let board = Board()
    let boardSize = 8
    private let disposeBag = DisposeBag()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(CellView.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    private lazy var dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<Int, Cell>>(
        configureCell: { [weak self] _, collectionView, indexPath, element in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CellView else {
                return UICollectionViewCell()
            }
            guard let self = self else { return UICollectionViewCell() }
            
            cell.configure(element)
            return cell
        })
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        board.cells.map { cells in
            [SectionModel(model: 0, items: cells.flatMap { $0 })]
        }
        .bind(to: collectionView.rx.items(dataSource: dataSource))
        .disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(Cell.self)
            .subscribe(onNext: { [weak self] cell in
//                print("Cell tapped: \(cell.index)")
                self?.board.pressOn(position: cell.position)
            })
            .disposed(by: disposeBag)
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ChessboardView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width / CGFloat(boardSize)
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
