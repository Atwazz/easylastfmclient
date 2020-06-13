//
//  ArtistViewModelFactory.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 28.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

protocol ArtistViewModelFactory {
    func viewModel(entity: ArtistEntity) -> ArtistViewModel
    func viewModel(artist: Artist) -> ArtistViewModel
}
