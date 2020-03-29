//
//  AlbumCollectionViewCell.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 21.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation
import UIKit

final class AlbumCollectionViewCell: UICollectionViewCell {
    // MARK: - Private instance propeties
    @IBOutlet private weak var albumImageView: UIImageView!
    @IBOutlet private weak var albumNameLabel: UILabel!
    @IBOutlet private weak var artistImageView: UIImageView!
    @IBOutlet private weak var artistNameLabel: UILabel!
}

// MARK: - Public
extension AlbumCollectionViewCell {
    func update(with model: AlbumCollectionViewModel) {
        albumNameLabel.text = model.albumName
        artistNameLabel.text = model.artistName
        albumImageView.setImage(with: model.albumImageUrl,
                                placeholderName: "no_data")
        artistImageView.setImage(with: model.artistImageUrl,
                                 placeholderName: "avatar_placeholder")
    }
}
