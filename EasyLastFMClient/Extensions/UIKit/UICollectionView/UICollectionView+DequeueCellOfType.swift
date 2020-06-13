//
//  UICollectionView+DequeueCellOfType.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 28.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UICollectionView

extension UICollectionView {
    func dequeueCell<T: UICollectionViewCell>(of type: T.Type,
                                              indexPath: IndexPath) -> T {
        let cellIdentifier = T.className
        let reusableCell = dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        guard let cell = reusableCell as? T else {
            fatalError("Cell has unexpected type")
        }
        return cell
    }
}
