//
//  AlbumModelFactoryBase.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 30.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation.NSURL

struct AlbumModelFactoryBase {
    // MARK: - Private instance properties
    private let albumFetcher: AlbumEntityFetcher
    private let backgroundTaskInvoker: PSBackgroundTaskInvoker
    
    // MARK: - Init
    init(albumFetcher: AlbumEntityFetcher,
         backgroundTaskInvoker: PSBackgroundTaskInvoker) {
        self.albumFetcher = albumFetcher
        self.backgroundTaskInvoker = backgroundTaskInvoker
    }
}

// MARK: - AlbumModelFactory
extension AlbumModelFactoryBase: AlbumModelFactory {
    func models(for albums: [Album], artistId: PSObjectID?, completion: @escaping ([AlbumModel]) -> Void) {
        guard let artistId = artistId else {
            completion(albums.map { albumModel(album: $0, id: nil) })
            return
        }
        backgroundTaskInvoker.performBackgroundTask { _ in
            completion(albums.map { self.albumModel(for: $0, artistId: artistId) })
        }
    }
}

// MARK: - Private
private extension AlbumModelFactoryBase {
    func albumModel(for album: Album, artistId: PSObjectID) -> AlbumModel {
        let albumEntity = albumFetcher.fetchAlbum(representing: album, artistId: artistId)
        return albumModel(album: album, id: albumEntity?.id)
    }
    
    func albumModel(album: Album, id: PSObjectID?) -> AlbumModel {
        AlbumModel(name: album.name,
                   mbid: album.mbid,
                   imageUrl: album.images?.imageUrl(size: .medium),
                   id: id)
    }
}
