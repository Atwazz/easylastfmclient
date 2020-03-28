//
//  AlbumTagsDataSource.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 28.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UICollectionView

final class AlbumTagsDataSource: NSObject {
    // MARK: - Private instance properties
    private var tags = [TagViewModel]()
}

// MARK: - Public
extension AlbumTagsDataSource {
    func setup(with tags: [TagViewModel]) {
        self.tags = tags
    }
}

// MARK: - UICollectionViewDataSource
extension AlbumTagsDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        tags.count > 0 ? 1 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(of: TagCell.self, indexPath: indexPath)
        cell.update(with: tags[indexPath.section])
        return cell
    }
}