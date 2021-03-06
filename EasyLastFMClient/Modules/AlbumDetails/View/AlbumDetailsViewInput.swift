//
//  AlbumDetailsViewInput.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UICollectionView

protocol AlbumDetailsViewInput {
    func showLoadingIndicator()
    func showNoDataPlaceholder()
    func update(with model: AlbumDetailsViewModel)
    func update(albumSaved: Bool)
    func disableSaveButton()
    func setup(with tagsDataSource: UICollectionViewDataSource)
}
