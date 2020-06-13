//
//  ArtistCellModelFactory.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 29.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

protocol ArtistCellModelFactory {
    func viewModel(for artist: Artist) -> ArtistCellModel
}
