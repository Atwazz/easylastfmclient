//
//  ArtistCellModelFactoryBase.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 29.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

struct ArtistCellModelFactoryBase { }

// MARK: - ArtistCellModelFactory
extension ArtistCellModelFactoryBase: ArtistCellModelFactory {
    func viewModel(for artist: Artist) -> ArtistCellModel {
        ArtistCellModel(name: artist.name,
                        imageUrl: artist.images?.imageUrl(size: .medium))
    }
}
