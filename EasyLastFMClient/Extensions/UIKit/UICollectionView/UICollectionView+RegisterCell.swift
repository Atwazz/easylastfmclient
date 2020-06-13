//
//  UICollectionView+RegisterCell.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 21.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UICollectionView

extension UICollectionView {
    func registerCell(_ type: NSObject.Type) {
        register(type.defaultNib, forCellWithReuseIdentifier: type.className)
    }
}
