//
//  AlbumCellModelFactoryBase.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 30.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

struct AlbumCellModelFactoryBase {
    // MARK: - Private instance properties
    private let artistFetcher: ArtistEntityFetcher
    
    // MARK: - Init
    init(artistFetcher: ArtistEntityFetcher) {
        self.artistFetcher = artistFetcher
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

// MARK - Private
private extension AlbumCellModelFactoryBase {
    func isSaved(album: Album, for artist: Artist) -> Bool {
        guard let artistEntity = artistFetcher.fetchArtist(representing: artist) else {
            return false
        }
        return artistEntity.album(for: album) != nil
    }
}
