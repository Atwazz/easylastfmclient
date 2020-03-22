//
//  AlbumCollectionViewModelFactoryBase.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 22.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation.NSURL

struct AlbumCollectionViewModelFactoryBase { }

// MARK: - AlbumCollectionViewModelFactory
extension AlbumCollectionViewModelFactoryBase: AlbumCollectionViewModelFactory {
    func model(for entity: AlbumEntity) -> AlbumCollectionViewModel {
        guard let albumName = entity.name,
            let artistName = entity.artist?.name else {
                fatalError("AlbumEntity has invalid state!")
        }
        let tracksCount = UInt(entity.tracks?.count ?? 0)
        let albumImageUrl = entity.imageUrl(size: .medium)
        let artistImageUrl = entity.artist?.imageUrl(size: .small)
        
        return AlbumCollectionViewModel(albumImageUrl: albumImageUrl,
                                        albumName: albumName,
                                        tracksCount: tracksCount,
                                        artistImageUrl: artistImageUrl,
                                        artistName: artistName)
    }
}
