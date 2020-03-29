//
//  AlbumsScreenInteractor.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 14.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

final class AlbumsScreenInteractor {
    // MARK: - Public instance properties
    weak var output: AlbumsScreenInteractorOutput?
    
    // MARK: - Private instanc properties
    private let albumsLoadService: ArtistAlbumsLoadService
    private let artistFetcher: ArtistEntityFetcher
    private let backgroundTaskInvoker: PSBackgroundTaskInvoker
    
    // MARK: - Init
    init(albumsLoadService: ArtistAlbumsLoadService,
         artistFetcher: ArtistEntityFetcher,
         backgroundTaskInvoker: PSBackgroundTaskInvoker) {
        self.albumsLoadService = albumsLoadService
        self.artistFetcher = artistFetcher
        self.backgroundTaskInvoker = backgroundTaskInvoker
    }
}

// MARK: - AlbumsScreenInteractorInput
extension AlbumsScreenInteractor: AlbumsScreenInteractorInput {
    func loadAlbums(artist: Artist, page: UInt?, pageSize: UInt?) {
        let completion: (ArtistAlbumsLoadService.AlbumsLoadResult) -> Void = { [weak self] result in
            guard case .success(let results) = result else {
                self?.output?.loadFailed()
                return
            }
            self?.output?.loadFinished(paginationInfo: results.paginationInfo,
                                       albums: results.albums)
        }
        if let mbid = artist.mbid {
            albumsLoadService.loadAlbums(artistMbid: mbid,
                                         page: page,
                                         pageSize: pageSize,
                                         completion: completion)
        } else {
            albumsLoadService.loadAlbums(artistName: artist.name,
                                         page: page,
                                         pageSize: pageSize,
                                         completion: completion)
        }
    }
}
