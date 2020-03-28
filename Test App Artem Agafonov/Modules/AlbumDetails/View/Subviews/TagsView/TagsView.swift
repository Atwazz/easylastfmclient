//
//  TagsView.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 28.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit

final class TagsView: UIView {
    // MARK: - Private instance properties
    @IBOutlet private weak var collectionView: UICollectionView!
    @DelayedImmutable private var itemSelectionBlock: (IndexPath) -> Void
    
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
               itemSelectionBlock: @escaping (IndexPath) -> Void) {
        collectionView.dataSource = dataSource
        collectionView.reloadData()
        self.itemSelectionBlock = itemSelectionBlock
    }
}

// MARK: - UICollectionViewDelegate
extension TagsView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        itemSelectionBlock(indexPath)
    }
}

// MARK: - Private
private extension TagsView {
    func setupCollectionView() {
        collectionView.registerCell(TagCell.self)
        collectionView.setupAutomaticFlowSize()
    }
}
