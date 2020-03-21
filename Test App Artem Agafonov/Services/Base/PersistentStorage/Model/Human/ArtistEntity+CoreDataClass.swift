//
//  ArtistEntity+CoreDataClass.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 21.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//
//

import Foundation
import CoreData

public class ArtistEntity: NSManagedObject { }

// MARK: - EntityWithImages
extension ArtistEntity: EntityWithImages { }

// MARK: - Public
extension ArtistEntity {
    func update(with model: Artist, in context: NSManagedObjectContext) {
        name = model.name
        url = model.url
        mbid = model.mbid
        replaceImages(with: model.images, in: context) { [weak self] in
            $0.artist = self
        }
    }
    
    func album(for model: AlbumExtendedInfo) -> AlbumEntity? {
        guard let albums = albums as? Set<AlbumEntity> else {
            return nil
        }
        return albums.filter { $0.name == model.name && $0.mbid == mbid }.first
    }
}

// MARK: - FetchRequests
extension ArtistEntity {
    static func fetchRequest(mbid: String?, name: String) -> NSFetchRequest<ArtistEntity> {
        let request: NSFetchRequest<ArtistEntity> = ArtistEntity.fetchRequest()
        request.fetchLimit = 1
        request.predicate = predicate(mbid: mbid, name: name)
        request.sortDescriptors = [defaultSortDescriptor]
        return request
    }
}

// MARK: - SortDescriptors
private extension ArtistEntity {
    static var defaultSortDescriptor: NSSortDescriptor {
        NSSortDescriptor(key: #keyPath(ArtistEntity.name), ascending: false)
    }
}

// MARK: - Predicates
private extension ArtistEntity {
    static func predicate(mbid: String?, name: String) -> NSPredicate {
        NSCompoundPredicate(andPredicateWithSubpredicates: [predicate(mbid: mbid),
                                                            predicate(name: name)])
    }
    
    static func predicate(mbid: String?) -> NSPredicate {
        guard let mbid = mbid else {
            return NSPredicate(format: "\(#keyPath(ArtistEntity.mbid)) = nil")
        }
        return NSPredicate(format: "\(#keyPath(ArtistEntity.mbid)) = %@", mbid)
    }
    
    static func predicate(name: String) -> NSPredicate {
        NSPredicate(format: "\(#keyPath(ArtistEntity.name)) == %@", name)
    }
}
