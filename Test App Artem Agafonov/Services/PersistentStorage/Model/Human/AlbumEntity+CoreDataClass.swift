//
//  AlbumEntity+CoreDataClass.swift
//  Test App Artem Agafonov
//
//  Created by Artem Agafonov on 21.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//
//

import Foundation.NSURL
import CoreData

public class AlbumEntity: NSManagedObject { }

// MARK: - EntityWithImages
extension AlbumEntity: EntityWithImages { }

// MARK: - FetchRequests
extension AlbumEntity {
    static func allAlbumsFetchRequest() -> NSFetchRequest<AlbumEntity> {
        let request: NSFetchRequest<AlbumEntity> = AlbumEntity.fetchRequest()
        request.sortDescriptors = [defaultSortDescriptor]
        return request
    }
    
    static func fetchRequest(mbid: String?,
                             name: String,
                             url: URL?,
                             artistId: PSObjectID) -> NSFetchRequest<AlbumEntity> {
        let request: NSFetchRequest<AlbumEntity> = AlbumEntity.fetchRequest()
        request.fetchLimit = 1
        request.predicate = predicate(mbid: mbid, name: name, url: url, artistId: artistId)
        return request
    }
}

// MARK: - SortDescriptors
private extension AlbumEntity {
    static var defaultSortDescriptor: NSSortDescriptor {
        NSSortDescriptor(key: #keyPath(AlbumEntity.name), ascending: false)
    }
}

// MARK: - Convenience
extension AlbumEntity {
    var tagsArray: [TagEntity]? {
        tags?.array(of: TagEntity.self)
    }

    var tracksArray: [TrackEntity]? {
        tracks?.array(of: TrackEntity.self)
    }
}

// MARK: - Predicates
private extension AlbumEntity {
    static func predicate(mbid: String?, name: String, url: URL?, artistId: PSObjectID) -> NSPredicate {
        NSCompoundPredicate(andPredicateWithSubpredicates: [predicate(mbid: mbid),
                                                            predicate(name: name),
                                                            predicate(url: url),
                                                            predicate(artistId: artistId)])
    }
    
    static func predicate(mbid: String?) -> NSPredicate {
        guard let mbid = mbid else {
            return NSPredicate(format: "\(#keyPath(AlbumEntity.mbid)) = nil")
        }
        return NSPredicate(format: "\(#keyPath(AlbumEntity.mbid)) == %@", mbid)
    }
    
    static func predicate(name: String) -> NSPredicate {
        NSPredicate(format: "\(#keyPath(AlbumEntity.name)) == %@", name)
    }
    
    static func predicate(url: URL?) -> NSPredicate {
        guard let url = url else {
            return NSPredicate(format: "\(#keyPath(AlbumEntity.url)) = nil")
        }
        return NSPredicate(format: "\(#keyPath(AlbumEntity.url)) == %@", url as NSURL)
    }
    
    static func predicate(artistId: PSObjectID) -> NSPredicate {
        NSPredicate(format: "\(#keyPath(AlbumEntity.artist)) = %@", artistId.asObjectId)
    }
}
