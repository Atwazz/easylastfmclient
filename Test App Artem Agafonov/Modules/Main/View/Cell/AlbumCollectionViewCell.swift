//
//  AlbumCollectionViewCell.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 21.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

final class AlbumCollectionViewCell: UICollectionViewCell {
    // MARK: - Private instance propeties
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistImageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
}

// MARK: - Public
extension AlbumCollectionViewCell {
    func update(with model: AlbumCollectionViewModel) {
        albumNameLabel.text = model.albumName
        artistNameLabel.text = model.artistName
        if let albumImageUrl = model.albumImageUrl {
            albumImageView.af.setImage(withURL: albumImageUrl)
        } else {
            albumImageView.image = UIImage(named: "AlbumImagePlaceholder")
        }
        if let artistImageUrl = model.artistImageUrl {
            artistImageView.af.setImage(withURL: artistImageUrl)
        } else {
            artistImageView.image = UIImage(named: "ArtistImagePlaceholder")
        }
    }
}
