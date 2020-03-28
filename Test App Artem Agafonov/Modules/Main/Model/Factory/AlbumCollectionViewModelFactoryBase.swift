//
//  AlbumCollectionViewModelFactoryBase.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 22.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

struct AlbumCollectionViewModelFactoryBase { }

// MARK: - AlbumCollectionViewModelFactory
extension AlbumCollectionViewModelFactoryBase: AlbumCollectionViewModelFactory {
    func model(for entity: AlbumEntity) -> AlbumCollectionViewModel {
        guard let albumName = entity.name,
            let artistName = entity.artist?.name else {
                fatalError("AlbumEntity has invalid state!")
        }
        let albumImageUrl = entity.imageUrl(size: .large)
        let artistImageUrl = entity.artist?.imageUrl(size: .medium)
        
        return AlbumCollectionViewModel(albumImageUrl: albumImageUrl,
                                        albumName: albumName,
                                        artistImageUrl: artistImageUrl,
                                        artistName: artistName)
    }
}
