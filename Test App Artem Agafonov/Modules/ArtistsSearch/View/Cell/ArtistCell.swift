//
//  ArtistCell.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 29.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UITableViewCell

final class ArtistCell: UITableViewCell {
    // MARK: - Private instance properties
    @IBOutlet private weak var artistImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
}

// MARK: - Public
extension ArtistCell {
    func update(with model: ArtistCellModel) {
        artistImageView.setImage(with: model.imageUrl, placeholderName: "avatar_placeholder")
        nameLabel.text = model.name
    }
}
