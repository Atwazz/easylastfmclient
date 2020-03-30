//
//  AlbumCellModelFactory.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 30.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

protocol AlbumCellModelFactory {
    func viewModel(for album: Album, artistId: PSObjectID?) -> AlbumCellModel
}
