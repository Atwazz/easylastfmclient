//
//  AlbumCell.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 30.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UITableViewCell

final class AlbumCell: UITableViewCell {
    // MARK: - Private instance properties
    @IBOutlet private weak var starImageView: UIImageView!
    @IBOutlet private weak var albumImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private var starImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet private var albumAndStarImageViewsSpaceConstraint: NSLayoutConstraint!
    
}

// MARK: - Public
extension AlbumCell {
    func update(with model: AlbumCellModel) {
        albumImageView.setImage(with: model.imageUrl, placeholderName: "no_data")
        nameLabel.text = model.name
        setStarImageView(hidden: !model.isSaved)
    }
}

// MARK: - Private
private extension AlbumCell {
    func setStarImageView(hidden: Bool) {
        let constraints: [NSLayoutConstraint] = [starImageViewWidthConstraint,
                                                 albumAndStarImageViewsSpaceConstraint]
        if hidden {
            NSLayoutConstraint.deactivate(constraints)
        } else {
            NSLayoutConstraint.activate(constraints)
        }
        starImageView.isHidden = hidden
     }
}
