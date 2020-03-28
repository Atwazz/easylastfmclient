//
//  SelfSizedCollectionView.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 29.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UICollectionView

final class SelfSizedCollectionView: UICollectionView {
    override func reloadData() {
        super.reloadData()
        invalidateIntrinsicContentSize()
    }

    override var intrinsicContentSize: CGSize {
        collectionViewLayout.collectionViewContentSize
    }
}
