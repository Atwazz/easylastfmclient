//
//  AlbumDetailsViewModelFactoryBase.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 28.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

struct AlbumDetailsViewModelFactoryBase {
    // MARK: - Private instance properties
    private let artistViewModelFactory: ArtistViewModelFactory
    private let tagViewModelFactory: TagViewModelFactory
    private let trackViewModelFactory: TrackViewModelFactory
    
    // MARK: - Init
    init(artistViewModelFactory: ArtistViewModelFactory,
         tagViewModelFactory: TagViewModelFactory,
         trackViewModelFactory: TrackViewModelFactory) {
        self.artistViewModelFactory = artistViewModelFactory
        self.tagViewModelFactory = tagViewModelFactory
        self.trackViewModelFactory = trackViewModelFactory
    }
}

// MARK: - AlbumDetailsViewModelFactory
extension AlbumDetailsViewModelFactoryBase: AlbumDetailsViewModelFactory {
    func viewModel(entity: AlbumEntity) -> ViewModel {
        guard let name = entity.name,
            let artistEntity = entity.artist,
            let trackEntities = entity.tracks?.array(of: TrackEntity.self) else {
                fatalError("AlbumEntity has invalid state!")
        }
        let tracks = trackEntities.map { trackViewModelFactory.vieModel(entity: $0) }
        let tags = entity.tags?.array(of: TagEntity.self)?
            .map { tagViewModelFactory.viewModel(entity: $0) }
        
        let artist = artistViewModelFactory.viewModel(entity: artistEntity)
        
        return ViewModel(name: name,
                         url: entity.url,
                         imageURL: entity.imageUrl(size: .extraLarge),
                         tracks: tracks,
                         tags: tags ?? [],
                         artist: artist,
                         published: entity.wiki?.published,
                         summary: entity.wiki?.summary)
        
    }
    
    func viewModel(albumExtendedInfo info: AlbumExtendedInfo, artist: Artist) -> ViewModel {
        let artistViewModel = artistViewModelFactory.viewModel(artist: artist)
        let tracks = info.tracks.map { trackViewModelFactory.viewModel(track: $0) }
        let tags = info.tags?.map { tagViewModelFactory.viewModel(tag: $0) }
        
        return ViewModel(name: info.name,
                         url: info.url,
                         imageURL: info.images?.imageUrl(size: .extraLarge),
                         tracks: tracks,
                         tags: tags ?? [],
                         artist: artistViewModel,
                         published: info.wiki?.published,
                         summary: info.wiki?.summary)
    }
}
