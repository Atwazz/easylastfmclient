//
//  CollectionViewDelegateFlowLayout.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 28.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UICollectionView

protocol CollectionViewDelegateFlowLayout: UICollectionViewDelegateFlowLayout {
    typealias ItemSelectionBlock = (IndexPath) -> Void
    
    func setup(itemSelectionBlock: @escaping ItemSelectionBlock)
}
