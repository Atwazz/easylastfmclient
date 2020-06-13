//
//  TagsView.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 28.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit

final class TagsView: UIView {
    // MARK: - Private instance properties
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadFromNib()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
}

// MARK: - Public
extension TagsView {
    func setup(dataSource: UICollectionViewDataSource,
               layoutDelegate: CollectionViewDelegateFlowLayout) {
        collectionView.delegate = layoutDelegate
        collectionView.dataSource = dataSource
        collectionView.reloadData()
    }
}

// MARK: - Private
private extension TagsView {
    func setupCollectionView() {
        collectionView.registerCell(TagCell.self)
    }
}
