//
//  ArtistViewModelFactoryBase.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 28.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

struct ArtistViewModelFactoryBase { }

// MARK: - ArtistViewModelFactory
extension ArtistViewModelFactoryBase: ArtistViewModelFactory {
    func viewModel(entity: ArtistEntity) -> ArtistViewModel {
        guard let name = entity.name else {
            fatalError("ArtistEntity has invalid state!")
        }
        return ArtistViewModel(name: name, url: entity.url,
                               imageURL: entity.imageUrl(size: .large))
    }
    
    func viewModel(artist: Artist) -> ArtistViewModel {
        ArtistViewModel(name: artist.name,
                        url: artist.url,
                        imageURL: artist.images?.imageUrl(size: .large))
    }
}
