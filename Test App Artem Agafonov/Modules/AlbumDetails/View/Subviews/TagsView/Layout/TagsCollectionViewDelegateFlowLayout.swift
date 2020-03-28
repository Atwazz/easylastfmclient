//
//  TagsCollectionViewDelegateFlowLayout.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 28.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UICollectionView
import UIKit.UIFont

final class TagsCollectionViewDelegateFlowLayout: NSObject {
    // MARK: - Private static properties
    private static let cellHeight: CGFloat = 30
    private static let textHorizontalPadding: CGFloat = 6
    
    // MARK: - Private instance properties
    @DelayedImmutable private var itemSelectionBlock: ItemSelectionBlock
    private let nameProvider: AlbumTagNameProvider
    
    // MARK: - Init
    init(nameProvider: AlbumTagNameProvider) {
        self.nameProvider = nameProvider
    }
}

// MARK: - CollectionViewDelegateFlowLayout
extension TagsCollectionViewDelegateFlowLayout: CollectionViewDelegateFlowLayout {
    func setup(itemSelectionBlock: @escaping ItemSelectionBlock) {
        self.itemSelectionBlock = itemSelectionBlock
    }
}

// MARK: - UICollectionViewDelegateFlowLayout {
extension TagsCollectionViewDelegateFlowLayout: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        itemSelectionBlock(indexPath)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let name = nameProvider.name(at: indexPath)
        let width = name.width(font: .preferredFont(forTextStyle: .footnote,
                                                       compatibleWith: nil))
        return CGSize(width: ceil(width) + Self.textHorizontalPadding * 2,
                      height: Self.cellHeight)
    }
}
