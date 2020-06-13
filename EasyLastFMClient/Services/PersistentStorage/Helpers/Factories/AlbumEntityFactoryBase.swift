//
//  AlbumEntityFactoryBase.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 21.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import CoreData.NSManagedObjectContext

struct AlbumEntityFactoryBase { }

// MARK: - AlbumEntityFactory
extension AlbumEntityFactoryBase: AlbumEntityFactory {
    func album(model: AlbumExtendedInfo,
               for artist: ArtistEntity,
               in context: NSManagedObjectContext) -> AlbumEntity {
        let entity = AlbumEntity(context: context)
        entity.artist = artist
        entity.name = model.name
        entity.url = model.url
        entity.mbid = model.mbid
        entity.replaceImages(with: model.images, in: context) { [weak entity] in
            $0.album = entity
        }
        let tracks = model.tracks.map {
            TrackEntity(context: context, model: $0) {
                $0.album = entity
                $0.artist = artist
            }
        }
        entity.addToTracks(Set(tracks) as NSSet)
        if let tags = model.tags {
            let tagEntities = tags.map { TagEntity(context: context, model: $0) { $0.album = entity } }
            entity.addToTags(Set(tagEntities) as NSSet)
        }
        entity.wiki = model.wiki.map { WikiEntity(context: context, model: $0) { $0.album = entity } }
        return entity
    }
}
