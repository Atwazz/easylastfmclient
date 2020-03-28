//
//  TagCell.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 28.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UICollectionViewCell

final class TagCell: UICollectionViewCell {
    // MARK: - Private instance properties
    @IBOutlet private weak var label: UILabel!
}

// MARK: - Public
extension TagCell {
    func update(with model: TagViewModel) {
        label.text = model.name
    }
}
