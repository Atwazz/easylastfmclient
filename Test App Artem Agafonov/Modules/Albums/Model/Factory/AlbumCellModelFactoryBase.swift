//
//  AlbumCellModelFactoryBase.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 30.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import CoreData.NSManagedObjectContext

struct AlbumCellModelFactoryBase {
    // MARK: - Private instance properties
    private let artistFetcher: ArtistEntityFetcher
    private let viewContextProvider: PSViewContextProvider
    
    // MARK: - Init
    init(artistFetcher: ArtistEntityFetcher,
         viewContextProvider: PSViewContextProvider) {
        self.artistFetcher = artistFetcher
        self.viewContextProvider = viewContextProvider
    }
}

// MARK: - AlbumCellModelFactory
extension AlbumCellModelFactoryBase: AlbumCellModelFactory {
    func viewModel(for album: Album, artist: Artist) -> AlbumCellModel {
        AlbumCellModel(name: album.name,
                       imageUrl: album.images?.imageUrl(size: .medium),
                       isSaved: isSaved(album: album, for: artist))
    }
}

// MARK: - Private
private extension AlbumCellModelFactoryBase {
    func isSaved(album: Album, for artist: Artist) -> Bool {
        var result = false
        viewContextProvider.viewContext.performAndWait {
            guard let artistEntity = self.artistFetcher.fetchArtist(representing: artist) else {
                return
            }
            result = artistEntity.album(for: album) != nil
        }
        return result
    }
}
