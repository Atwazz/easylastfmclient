//
//  AlbumEntityFactoryBase.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 21.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import CoreData.NSManagedObjectContext

struct AlbumEntityFactoryBase { }

// MARK: - AlbumEntityFactory
extension AlbumEntityFactoryBase: AlbumEntityFactory {
    func album(model: AlbumExtendedInfo,
               in context: NSManagedObjectContext) -> AlbumEntity {
        let entity = AlbumEntity(context: context)
        entity.name = model.name
        entity.url = model.url
        entity.mbid = model.mbid
        entity.replaceImages(with: model.images, in: context) { [weak entity] in
            $0.album = entity
        }
        let tracks = model.tracks.map { TrackEntity(context: context, model: $0) { $0.album = entity } }
        entity.addToTracks(Set(tracks) as NSSet)
        let tags = model.tags.map { TagEntity(context: context, model: $0) { $0.album = entity } }
        entity.addToTags(Set(tags) as NSSet)
        entity.wiki = model.wiki.map { WikiEntity(context: context, model: $0) { $0.album = entity } }
        return entity
    }
}
