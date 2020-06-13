//
//  UICollectionView+AutomaticFlowSize.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 28.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UICollectionView

extension UICollectionView {
    func setupAutomaticFlowSize() {
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
}
