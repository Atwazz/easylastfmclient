//
//  AlbumsCollectionViewDelegateFlowLayout.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 28.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UICollectionView

final class AlbumsCollectionViewDelegateFlowLayout: NSObject {    
    // MARK: - Private static properties
    private static let minimumItemSpacing: CGFloat = 10
    private static let itemsPerRow: CGFloat = 2
    
    // MARK: - Private instance properties
    @DelayedImmutable private var itemSelectionBlock: ItemSelectionBlock
}

// MARK: - CollectionViewDelegateFlowLayout
extension AlbumsCollectionViewDelegateFlowLayout: CollectionViewDelegateFlowLayout {
    func setup(itemSelectionBlock: @escaping ItemSelectionBlock) {
        self.itemSelectionBlock = itemSelectionBlock
    }
}

// MARK: - UICollectionViewDelegateFlowLayout {
extension AlbumsCollectionViewDelegateFlowLayout: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        itemSelectionBlock(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = Self.minimumItemSpacing * (Self.itemsPerRow - 1)
        let availableWidth = min(collectionView.bounds.width, collectionView.bounds.height) - paddingSpace
        let widthPerItem = availableWidth / Self.itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        Self.minimumItemSpacing
    }
}
