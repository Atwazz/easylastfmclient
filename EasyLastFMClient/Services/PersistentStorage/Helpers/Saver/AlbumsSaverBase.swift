//
//  AlbumsSaverBase.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 21.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import Foundation
import CoreData.NSManagedObjectContext

final class AlbumsSaverBase {
    // MARK: - Private properties
    private let backgroundTaskInvoker: PSBackgroundTaskInvoker
    private let artistFetcher: ArtistEntityFetcher
    private let albumFetcher: AlbumEntityFetcher
    private let albumFactory: AlbumEntityFactory
    
    // MARK: - Init
    init(backgroundTaskInvoker: PSBackgroundTaskInvoker,
         artistFetcher: ArtistEntityFetcher,
         albumFetcher: AlbumEntityFetcher,
         albumFactory: AlbumEntityFactory) {
        self.backgroundTaskInvoker = backgroundTaskInvoker
        self.artistFetcher = artistFetcher
        self.albumFetcher = albumFetcher
        self.albumFactory = albumFactory
    }
}

// MARK: - AlbumsSaver
extension AlbumsSaverBase: AlbumsSaver {
    func save(albums: [AlbumExtendedInfo],
              for artist: Artist,
              completion: @escaping (SaverResult) -> Void) {
        backgroundTaskInvoker.performBackgroundTask { [weak self] context in
            guard let self = self else { return }
            let artistEntity = self.artistFetcher.fetchArtist(representing: artist) ?? ArtistEntity(context: context)
            artistEntity.update(with: artist, in: context)
            let entities = self.saveAlbums(models: albums, artist: artistEntity, in: context)
            self.save(context: context, entities: entities, completion: completion)
        }
    }
}

// MARK: - Private
private extension AlbumsSaverBase {
    func saveAlbums(models: [AlbumExtendedInfo],
                    artist: ArtistEntity,
                    in context: NSManagedObjectContext) -> [AlbumEntity] {
        models.map { saveAlbum(model: $0, artist: artist, in: context) }
    }
    
    func saveAlbum(model: AlbumExtendedInfo,
                   artist: ArtistEntity,
                   in context: NSManagedObjectContext) -> AlbumEntity {
        let existingEntity = albumFetcher.fetchAlbum(representing: model, artistId: artist.id)
        if let existingEntity = existingEntity {
            assertionFailure("Trying to add already saved album: \(model.name)")
            return existingEntity
        }
        let entity = albumFactory.album(model: model, for: artist, in: context)
        return entity
    }
    
    func save(context: NSManagedObjectContext,
              entities: [AlbumEntity],
              completion: (SaverResult) -> Void) {
        do {
            try context.save()
            try context.obtainPermanentIDs(for: entities)
            completion(.success(entities.map { $0.id }))
        } catch {
            assertionFailure("Unexpected error occured: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }
}
