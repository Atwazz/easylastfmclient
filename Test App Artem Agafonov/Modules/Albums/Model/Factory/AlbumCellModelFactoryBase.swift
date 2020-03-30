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
    private let albumFetcher: AlbumEntityFetcher
    private let viewContextProvider: PSViewContextProvider
    
    // MARK: - Init
    init(albumFetcher: AlbumEntityFetcher,
         viewContextProvider: PSViewContextProvider) {
        self.albumFetcher = albumFetcher
        self.viewContextProvider = viewContextProvider
    }
}

// MARK: - AlbumCellModelFactory
extension AlbumCellModelFactoryBase: AlbumCellModelFactory {
    func viewModel(for album: Album, artistId: PSObjectID?) -> AlbumCellModel {
        AlbumCellModel(name: album.name,
                       imageUrl: album.images?.imageUrl(size: .medium),
                       isSaved: isSaved(album: album, for: artistId))
    }
}

// MARK: - Private
private extension AlbumCellModelFactoryBase {
    func isSaved(album: Album, for artistId: PSObjectID?) -> Bool {
        guard let artistId = artistId else {
            return false
        }
        
        var result = false
        viewContextProvider.viewContext.performAndWait {
            result = self.albumFetcher.fetchAlbum(representing: album, artistId: artistId) != nil
        }
        return result
    }
}
